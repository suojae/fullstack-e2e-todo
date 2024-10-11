import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Counter } from './counter.entity';
import { CounterGateway } from './counter.gateway';

@Injectable()
export class CounterService {
  constructor(
    @InjectRepository(Counter)
    private counterRepository: Repository<Counter>,
    private counterGateway: CounterGateway, // Inject the gateway
  ) {}

  async getCounter(): Promise<number> {
    const counter = await this.counterRepository.findOne({ where: { id: 1 } });
    return counter ? counter.value : 0;
  }

  async incrementCounter(): Promise<number> {
    let counter = await this.counterRepository.findOne({ where: { id: 1 } });
    if (!counter) {
      counter = this.counterRepository.create({ value: 1 });
    } else {
      counter.value++;
    }
    await this.counterRepository.save(counter);

    // Emit the updated counter value to all connected clients
    this.counterGateway.server.emit('counterUpdated', counter.value);

    return counter.value;
  }
}
