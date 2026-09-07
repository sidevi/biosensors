import { Controller, Post, Body, Get, Param } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Device } from './device.entity';

@Controller('devices')
export class DevicesController {
  constructor(
    @InjectRepository(Device)
    private readonly deviceRepo: Repository<Device>,
  ) {}

  @Post()
  async create(@Body() payload: { name?: string; serialNumber?: string; patient?: { id: string } }) {
    const device = this.deviceRepo.create({
      name: payload.name ?? `ECG Monitor ${Math.floor(Math.random() * 1000)}`,
      serialNumber: payload.serialNumber ?? `SN-${Date.now()}`,
      patient: payload.patient,
    });
    return this.deviceRepo.save(device);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.deviceRepo.findOne({
      where: { id },
      relations: { patient: true },
    });
  }
}
