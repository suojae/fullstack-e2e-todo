import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: ['http://192.168.10.120', 'http://127.0.0.1', 'http://localhost'],
    methods: 'GET,POST',
    credentials: true,
  });
  await app.listen(3000);
}

bootstrap();
