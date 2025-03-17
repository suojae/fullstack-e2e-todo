## 온프레미스 배포 프로젝트

<br/>

## 인프라 - Oracle VirtualBox에서 가상화한 Rocky Linux로 Ethernet 연결 간 To-Do 공유

### **Ethernet을 통한 프라이빗한 To-Do 공유**

- Ethernet 연결을 통해 외부 접근이 차단된 프라이빗 네트워크를 구성
- Node.js 기반의 REST API 서버가 To-Do 데이터를 관리
- 방화벽을 설정하여 외부 접근을 차단하고 내부 사용자 간 안전한 데이터 공유를 보장
- To-Do 데이터는 MariaDB에 저장되고, 사용자 간 동기화

<br/>
<br/>


### 다이어그램

<img src="https://github.com/user-attachments/assets/f242f065-b3b8-400c-8585-da1ca024d24b" width="400">


   
<img src="https://github.com/user-attachments/assets/531bb832-f629-47bd-bb9a-d0a52e2a07d0" width="500">

<br/>

### CICD 구조

<img src="https://github.com/user-attachments/assets/5e4cface-8fd4-4856-82d2-32e8e23fe3d3" width="250">

<br/>
<br/>
<br/>

<details>
<summary> 트러블슈팅 01 - 보안 강화를 위한 비대칭키(공개키 기반 인증)로 SSH 연결 설정 </summary>

<br/>

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



**결과**

<img width="500" alt="image" src="https://github.com/user-attachments/assets/73249dcd-843f-4260-a6d0-31d8099e871d">
<img src="https://github.com/user-attachments/assets/7eca9cb2-83e1-405c-9529-4646faa60151" width="500">

- 맥북에서 LG노트북에 가상화된 Locky Linux로 플러터웹 이더넷에 배포 완료!


</details> <br/>


<details>
  <summary>Flutter 웹 애플리케이션 배포 트러블슈팅</summary>

### Flutter 웹 애플리케이션 배포 트러블슈팅

### 문제 상황
- Flutter 웹 애플리케이션을 Rocky Linux 서버에 배포하기 위해, 로키리눅스에 flutter를 설치해야했다.
- Flutter SDK는 용량이 크기 때문에 서버에 직접 설치하는 것은 서버 자원의 낭비이며, 불필요한 복잡성을 유발하기 때문에 깃헙 액션 cicd로 해결했다.

### 해결 방법
1. **로컬 환경에서 Flutter 빌드**
   - Flutter SDK는 서버가 아닌 로컬 개발 환경(MacBook 등)에 설치하고, **로컬에서 빌드된 결과물**만 서버에 배포하기로 결정.
   - `flutter build web` 명령어를 사용하여 Flutter 웹 애플리케이션을 빌드하고, 그 결과물은 HTML, CSS, JavaScript 파일로 구성된다.

2. **GitHub Actions에서 Flutter 설치 및 빌드 제거**
   - GitHub Actions 워크플로우에서 Flutter를 설치하지 않고, 대신 **로컬에서 빌드한 파일들을 서버에 복사**하는 방식으로 변경하였다.
   - 로컬에서 빌드된 파일을 SCP를 통해 Rocky Linux 서버의 NGINX가 서빙하는 디렉토리(`/usr/share/nginx/html`)로 복사하였다.

3. **빌드 결과물 배포**
   - 로컬에서 빌드된 Flutter 웹 파일을 서버로 전송한 후, NGINX를 재시작하여 최신 파일이 반영되도록 하였다.
   - 이 과정에서 서버에는 Flutter SDK가 설치되지 않으므로, 서버 리소스를 절약하고 유지보수가 더 쉬워졌다.

### 결론
- Flutter 웹 애플리케이션을 배포할 때, 서버에 Flutter SDK를 설치하지 않고 **로컬 환경에서 빌드한 결과물만 서버에 배포하는 방식**을 선택하였다.
- 이를 통해 서버 자원을 절약하고, 서버 환경을 단순하게 유지할 수 있었다. 또한, 빌드와 배포 과정을 분리함으로써 배포 파이프라인이 더욱 효율적으로 동작하게 되었다.

</details> <br/>
