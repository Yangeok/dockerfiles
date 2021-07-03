# NiFi for Docker

## Description

- 컨테이너에는 MySQL, NiFi가 올라감

- 폴더 구조
  - `data`: `GetFile` 프로세서를 컨테이너 안에서 사용하기 위해 로컬과 연결된 폴더
  - `init.db`: mysql 컨테이너 실행시 `CREATE DATABASE *` 및 스키머를 집어넣기 위한 초기화 sql 파일이 있는 폴더
  - `templates`: 작업한 플로우를 보관하는 폴더

## Execution

- 컨테이너 실행
```sh
$ docker-compose up --build
```

- 컨테이너 접속
  - NiFi
  ```sh
  $ docker-compose exec nifi /bin/bash
  ```
  - MySQL
  ```sh
  $ docker-compose exec mysql /bin/bash
  ```
