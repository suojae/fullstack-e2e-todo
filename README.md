## 프론트-백엔드-인프라 구축까지 E2E 미니 프로젝트

<br/>

## 인프라 - Oracle VirtualBox에서 가상화한 Rocky Linux로 Ethernet 연결 간 To-Do 공유

### **Ethernet을 통한 프라이빗한 To-Do 공유**

- Ethernet 연결을 통해 외부 접근이 차단된 프라이빗 네트워크를 구성
- Node.js 기반의 REST API 서버가 To-Do 데이터를 관리
- 방화벽을 설정하여 외부 접근을 차단하고 내부 사용자 간 안전한 데이터 공유를 보장
- To-Do 데이터는 MariaDB에 저장되고, 사용자 간 동기화

<br/>

### **트러블슈팅 01 - 보안 강화를 위한 비대칭키(공개키 기반 인증)로 SSH 연결 설정**

**문제:**

<img width="500" alt="image" src="https://github.com/user-attachments/assets/651a976c-67e8-4e76-a76c-4dc873b05011">


- 맥북과 Oracle VirtualBox로 가상화한 LG 노트북(Rocky Linux) 간 SSH 연결이 보안 문제로 인해 비밀번호 인증이 작동하지 않았음.
- 비밀번호 기반 인증 방식이 보안 위험이 있어 서버에서 비활성화되어 있었음.

**해결 방법:**

<img src="https://github.com/user-attachments/assets/9892c520-680b-4f0c-84a3-2399f156e9ac" width="300">
<img width="500" alt="image" src="https://github.com/user-attachments/assets/a7fa94c1-8326-4b6f-80b3-20af125431a7">

- **보안 강화를 위해** SSH 비대칭키(공개키 기반 인증) 방식으로 문제를 해결.
- 먼저, 맥북에서 다음 명령어를 사용하여 RSA 키 쌍을 생성:
  
  ```bash
  ssh-keygen -t rsa -b 4096
  ```
- 이후, ssh-copy-id 명령어를 사용하여 맥북의 공개키를 LG 노트북의 ~/.ssh/authorized_keys 파일에 추가하여 서버에 등록.

   ```bash
   ssh-copy-id root@192.168.x.x
   ```

- 공개키가 성공적으로 등록된 후, 비밀번호 없이 SSH 접속이 가능해졌고, 이를 통해 보안이 강화된 상태에서 서버(LG노트북에 가상화해둔 locky linux)에 접근 가능하게 됨.










<br/>


### 다이어그램

<img src="https://github.com/user-attachments/assets/f242f065-b3b8-400c-8585-da1ca024d24b" width="500">


   
<img src="https://github.com/user-attachments/assets/531bb832-f629-47bd-bb9a-d0a52e2a07d0" width="500">


<br/>
<br/>

## 백엔드 - Nodejs

<br/>
<br/>


## 프론트 - Flutter Web
