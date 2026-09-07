import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, OneToMany, JoinColumn } from 'typeorm';
import { Patient } from '../patients/patient.entity';
import { Reading } from '../readings/reading.entity';

@Entity()
export class Device {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column()
  name!: string;

  @Column({ unique: true })
  serialNumber!: string;

  @ManyToOne(() => Patient, (patient) => patient.devices, { onDelete: 'CASCADE', nullable: true })
  @JoinColumn({ name: 'patientId' })
  patient!: Patient;

  @OneToMany(() => Reading, (reading) => reading.device)
  readings!: Reading[];
}