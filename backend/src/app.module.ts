import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Counter } from './counter.entity';
import { CounterController } from './app.controller';
import { CounterService } from './app.service';
import { CounterGateway } from './counter.gateway'; // Import the gateway

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql', // 또는 'mariadb'
      host: '192.168.10.120', // MariaDB가 설치된 서버 IP
      port: 3306, // MariaDB 기본 포트
      username: 'suojae', // 실제 MariaDB 사용자 이름
      password: '486579zz!', // 실제 MariaDB 비밀번호
      database: 'suojae', // 사용할 데이터베이스 이름
      entities: [Counter], // 사용하려는 엔티티 등록
      synchronize: true, // 애플리케이션 시작 시 테이블 동기화
    }),
    TypeOrmModule.forFeature([Counter]), // Counter 엔티티 등록
  ],
  controllers: [CounterController],
  providers: [CounterService, CounterGateway], // Register the gateway
})
export class AppModule {}
