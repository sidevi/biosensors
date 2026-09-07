import { io } from 'socket.io-client';

const API_URL = 'http://localhost:3000';

async function runSimulation() {
  try {
    console.log('1. Creating Patient in PostgreSQL...');
    const patientRes = await fetch(`${API_URL}/patients`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: 'Jane Doe', age: 30 }),
    }).then((r) => r.json());

    if (!patientRes?.id) {
      throw new Error(`Failed to create patient: ${JSON.stringify(patientRes)}`);
    }
    console.log(`   Patient Created ID: ${patientRes.id}`);

    console.log('2. Creating Device linked to Patient...');
    const deviceRes = await fetch(`${API_URL}/devices`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        serialNumber: `ECG-${Date.now()}`,
        patient: { id: patientRes.id },
      }),
    }).then((r) => r.json());

    if (!deviceRes?.id) {
      throw new Error(`Failed to create device: ${JSON.stringify(deviceRes)}`);
    }
    console.log(`   Device Created ID: ${deviceRes.id}`);

    console.log(`3. Connecting Socket.io client for patient room...`);
    const socket = io(API_URL, { transports: ['websocket'] });

    socket.on('connect', () => {
      console.log('   Connected to WebSocket Gateway!');
      socket.emit('join_patient_room', { patientId: patientRes.id });
    });

    socket.on('joined_room', (data) => {
      console.log('   Successfully joined room:', data);
      console.log('4. Ingesting telemetry reading to POST /readings/ingest...');

      fetch(`${API_URL}/readings/ingest`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          deviceId: deviceRes.id,
          data: { heartRate: 88, spo2: 99, ecgValue: 1.12 },
          anomalyFlag: false,
        }),
      });
    });

    socket.on('telemetry_update', (data) => {
      console.log('\n====================================');
      console.log('SUCCESS! RECEIVED REAL-TIME BROADCAST:');
      console.log(data);
      console.log('====================================\n');
      socket.disconnect();
      process.exit(0);
    });

  } catch (error) {
    console.error('Simulation Failed:', error);
    process.exit(1);
  }
}

runSimulation();
