# jusoro
juso.go.kr 주소검색솔루션 docker

## 주소검색솔루션 다운로드
* #### http://www.juso.go.kr

## 메뉴
* #### OPEN API 클릭 > 주소검색솔루션 > 주소검색솔루션 클릭

## 주소검색솔루션 다운로드
* #### 리눅스 64bit(인터넷망) jusoro-1.1.0-linux64-internet.tar.gz
* #### 주소검색솔루션, 자바, jetty(WEB), tomcat이 포함되어있음
* #### 활용가이드 참고

## 폴더 구조
* home
  * username
    * docker
      * jusoro (기본폴더)
        * Dockerfile (도커 빌드파일)
        * README.md
        * juso (주소검색솔루션 폴더)
          * jetty.xml (web 설정)
          * jusoro-1.1.0-linux64-internet.tar (주소검색솔루션)
          * startup.sh (톰켓 스크립트)

## Dockerfile 설명
* 전체 소스
<pre><code>
FROM ubuntu:16.04
MAINTAINER harry <latemorning@gmail.com>

RUN apt-get -y -qq update && \
    useradd -ms /bin/bash -p jusoro jusoro && \
    mkdir -p /app/jusoro-1.1.0-linux64-internet

COPY juso/jusoro-1.1.0-linux64-internet.tar /app/

RUN chown -R jusoro:jusoro /app/jusoro-1.1.0-linux64-internet
RUN chown -R jusoro:jusoro /app/jusoro-1.1.0-linux64-internet.tar

USER jusoro

RUN tar -xvf /app/jusoro-1.1.0-linux64-internet.tar -C /app/jusoro-1.1.0-linux64-internet/ && \
    chmod -R 755 /app/jusoro-1.1.0-linux64-internet && \
    rm -f /app/jusoro-1.1.0-linux64-internet.tar

COPY juso/jetty.xml /app/jusoro-1.1.0-linux64-internet/jusoro/server/etc/
COPY juso/startup.sh /app/jusoro-1.1.0-linux64-internet/jusoro/bin/

WORKDIR /app/jusoro-1.1.0-linux64-internet/jusoro/bin

EXPOSE 8983
CMD ["/app/jusoro-1.1.0-linux64-internet/jusoro/bin/startup.sh"]
</code></pre>

* ubuntu:16.04 도커 이미지 사용
<pre><code>
FROM ubuntu:16.04
</code></pre>

* juso 컨테이너 서버 업데이트, jusoro 사용자 추가, 주소검색솔루션 설치 폴더 생성
<pre><code>
RUN apt-get -y -qq update && \
    useradd -ms /bin/bash -p jusoro jusoro && \
    mkdir -p /app/jusoro-1.1.0-linux64-internet
</code></pre>

* 호스트 서버 jusoro-1.1.0-linux64-internet.tar 파일을 juso 컨테이너 서버 /app/ 폴더에 복사, 권한부여, jusoro 사용자로 작업
<pre><code>
COPY juso/jusoro-1.1.0-linux64-internet.tar /app/

RUN chown -R jusoro:jusoro /app/jusoro-1.1.0-linux64-internet
RUN chown -R jusoro:jusoro /app/jusoro-1.1.0-linux64-internet.tar

USER jusoro
</code></pre>

* 주소검색 솔루션 압축 해제, 압축해제 폴더 권한 변경, 솔루션 압축파일 삭제
<pre><code>
RUN tar -xvf /app/jusoro-1.1.0-linux64-internet.tar -C /app/jusoro-1.1.0-linux64-internet/ && \
    chmod -R 755 /app/jusoro-1.1.0-linux64-internet && \
    rm -f /app/jusoro-1.1.0-linux64-internet.tar
</code></pre>

* 호스트 서버의 설정파일을 juso 컨테이너에 복사, 작업폴더 변경
<pre><code>
COPY juso/jetty.xml /app/jusoro-1.1.0-linux64-internet/jusoro/server/etc/
COPY juso/startup.sh /app/jusoro-1.1.0-linux64-internet/jusoro/bin/

WORKDIR /app/jusoro-1.1.0-linux64-internet/jusoro/bin
</code></pre>

* 8983 포트 사용, 서버시작 스크립트 실행
<pre><code>
EXPOSE 8983
CMD ["/app/jusoro-1.1.0-linux64-internet/jusoro/bin/startup.sh"]
</code></pre>

### docker build (기본폴더에서 실행)
* docker build -t jusoro .

### docker run
* docker run --name jusoro -d -p 8983:8983 jusoro
