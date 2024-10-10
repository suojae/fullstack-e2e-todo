# 프론트-백엔드-인프라 구축까지 E2E 미니 프로젝트


## 인프라 - Oracle VM에서 가상화한 Rocky Linux로 Ethernet 연결 간 To-Do 공유

1. **Rocky Linux 가상화 이유**
   - 격리된 테스트 환경을 제공
   - 확장성 테스트 및 유연한 서버 관리가 가능
   - 네트워크 시뮬레이션을 통해 실제 환경과 유사한 조건을 제공

2. **Ethernet을 통한 프라이빗한 To-Do 공유**
   - Ethernet 연결을 통해 외부 접근이 차단된 프라이빗 네트워크를 구성
   - Node.js 기반의 REST API 서버가 To-Do 데이터를 관리
   - 방화벽을 설정하여 외부 접근을 차단하고 내부 사용자 간 안전한 데이터 공유를 보장
   - To-Do 데이터는 MariaDB에 저장되고, 사용자 간 동기화


## 백엔드 - Nodejs

## 프론트 - Flutter
