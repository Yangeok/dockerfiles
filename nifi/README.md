# Apache NiFi for Docker

## Description

- 컨테이너에는 NiFi, NiFi Registry가 올라감

- 폴더 구조
  - `data`: `GetFile` 프로세서를 컨테이너 안에서 사용하기 위해 로컬과 연결
  - `drivers`: 데이터베이스 드라이버 위치
  - `nifi_registry`: NiFi 버전관리를 하기 위한 NiFi Registry 위치
  - `templates`: 작업한 플로우를 보관

## Execution

- 폴더 생성

  ```sh
  mkdir data \
    driver \
    nifi_registry/flow_storage \ # NiFi Registry 버전관리용 폴더
  ```

- 컨테이너 실행

```sh
docker-compose up --build
```

- 컨테이너 접속
  - NiFi

  ```sh
  docker-compose exec nifi /bin/bash
  ```

  - NiFi Registry

  ```sh
  docker-compose exec nifi_registry /bin/bash
  ```
