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
