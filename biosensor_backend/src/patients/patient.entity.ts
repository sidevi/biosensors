import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { Device } from '../devices/device.entity';

@Entity()
export class Patient {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column()
  name!: string;

  @Column()
  age!: number;

  @Column({ unique: true })
  mrn!: string;

  @OneToMany(() => Device, (device) => device.patient)
  devices!: Device[];
}