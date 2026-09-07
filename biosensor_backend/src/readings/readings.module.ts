import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ReadingsController } from './readings.controller';
import { ReadingsService } from './readings.service';
import { Reading } from './reading.entity';
import { Device } from '../devices/device.entity';
import { TelemetryGateway } from './telemetry.gateway';

@Module({
  imports: [TypeOrmModule.forFeature([Reading, Device])],
  controllers: [ReadingsController],
  providers: [ReadingsService, TelemetryGateway],
  exports: [ReadingsService, TelemetryGateway],
})
export class ReadingsModule {}
