import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Device } from '../devices/device.entity';

@Entity()
export class Reading {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @ManyToOne(() => Device, (device) => device.readings, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'deviceId' })
  device!: Device;

  @Column({ type: 'timestamp' })
  timestamp!: Date;

  @Column({ type: 'jsonb' })
  data!: Record<string, any>;

  @Column({ default: false })
  anomalyFlag!: boolean;
}