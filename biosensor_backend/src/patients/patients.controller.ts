import { Controller, Post, Body, Get, Param } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Patient } from './patient.entity';

@Controller('patients')
export class PatientsController {
  constructor(
    @InjectRepository(Patient)
    private readonly patientRepo: Repository<Patient>,
  ) {}

  @Post()
  async create(@Body() payload: { name: string; age: number; mrn?: string }) {
    const mrnValue = payload.mrn ?? `MRN-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
    const patient = this.patientRepo.create({
      name: payload.name,
      age: payload.age,
      mrn: mrnValue,
    });
    return this.patientRepo.save(patient);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.patientRepo.findOneBy({ id });
  }
}
