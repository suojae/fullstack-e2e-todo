import { Controller, Get, Post } from '@nestjs/common';
import { CounterService } from './app.service';

@Controller('counter')
export class CounterController {
  constructor(private readonly counterService: CounterService) {}

  @Get()
  async getCounter(): Promise<number> {
    return this.counterService.getCounter();
  }

  @Post('increment')
  async incrementCounter(): Promise<number> {
    return this.counterService.incrementCounter();
  }
}
