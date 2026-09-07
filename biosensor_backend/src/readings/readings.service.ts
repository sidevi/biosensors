import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Reading } from './reading.entity';
import { Device } from '../devices/device.entity';
import { TelemetryGateway } from './telemetry.gateway';

@Injectable()
export class ReadingsService {
  constructor(
    @InjectRepository(Reading)
    private readingRepository: Repository<Reading>,
    @InjectRepository(Device)
    private deviceRepository: Repository<Device>,
    private telemetryGateway: TelemetryGateway,
  ) {}

  async createReading(deviceId: string, data: Record<string, any>, anomalyFlag = false) {
    const device = await this.deviceRepository.findOne({
      where: { id: deviceId },
      relations: { patient: true },
    });

    if (!device) {
      throw new Error('Device not found');
    }

    const reading = this.readingRepository.create({
      device,
      timestamp: new Date(),
      data,
      anomalyFlag,
    });

    const savedReading = await this.readingRepository.save(reading);

    if (device.patient?.id) {
      this.telemetryGateway.broadcastReading(device.patient.id, savedReading);
    }

    return savedReading;
  }
}
