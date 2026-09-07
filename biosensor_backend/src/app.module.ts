import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { PatientsModule } from './patients/patients.module';
import { DevicesModule } from './devices/devices.module';
import { ReadingsModule } from './readings/readings.module';
import { Patient } from './patients/patient.entity';
import { Device } from './devices/device.entity';
import { Reading } from './readings/reading.entity';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => ({
        type: 'postgres',
        url: config.get<string>('DATABASE_URL'),
        ssl: { rejectUnauthorized: false },
        entities: [Patient, Device, Reading],
        synchronize: true,
      }),
    }),
    PatientsModule,
    DevicesModule,
    ReadingsModule,
  ],
})
export class AppModule {}
