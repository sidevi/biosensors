import { Controller, Post, Body } from '@nestjs/common';
import { ReadingsService } from './readings.service';

@Controller('readings')
export class ReadingsController {
  constructor(private readonly readingsService: ReadingsService) {}

  @Post('ingest')
  async ingest(@Body() payload: { deviceId: string; data: Record<string, any>; anomalyFlag?: boolean }) {
    return this.readingsService.createReading(
      payload.deviceId,
      payload.data,
      payload.anomalyFlag ?? false,
    );
  }
}
