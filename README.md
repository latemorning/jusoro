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
 * ##### jetty.xml, startup.sh 파일에서 접근가능 IP와 메모리 설정을 함 자세한 내용은 활용가이드 

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
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash -p jusoro jusoro && \
    mkdir -p /app/jusoro-1.1.0-linux64-internet

COPY juso/jusoro-1.1.0-linux64-internet.tar /app/

RUN tar -xvf /app/jusoro-1.1.0-linux64-internet.tar -C /app/jusoro-1.1.0-linux64-internet/ && \
    rm -rf /app/jusoro-1.1.0-linux64-internet.tar && \
    chmod -R 755 /app/jusoro-1.1.0-linux64-internet && \
    chown -R jusoro:jusoro /app/jusoro-1.1.0-linux64-internet
    
USER jusoro

COPY juso/jetty.xml /app/jusoro-1.1.0-linux64-internet/jusoro/server/etc/
COPY juso/startup.sh /app/jusoro-1.1.0-linux64-internet/jusoro/bin/

WORKDIR /app/jusoro-1.1.0-linux64-internet/jusoro/bin

EXPOSE 8983
CMD ["/app/jusoro-1.1.0-linux64-internet/jusoro/bin/startup.sh"]
</code></pre>


### docker build (기본폴더에서 실행)
* docker build -t jusoro .

### docker run
* docker run --name jusoro -d -p 8983:8983 jusoro
