import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class TelemetryGateway {
  @WebSocketServer()
  server!: Server;

  @SubscribeMessage('join_patient_room')
  handleJoinRoom(
    @MessageBody() data: { patientId: string },
    @ConnectedSocket() client: Socket,
  ) {
    client.join(`patient_${data.patientId}`);
    return { event: 'joined_room', room: `patient_${data.patientId}` };
  }

  // Called by ReadingsService to emit telemetry to Flutter clients in real-time
  broadcastReading(patientId: string, readingData: any) {
    this.server.to(`patient_${patientId}`).emit('telemetry_update', readingData);
  }
}
