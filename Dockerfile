FROM ubuntu:16.04
MAINTAINER harry <latemorning@gmail.com>

RUN apt-get -y -qq update && \
    useradd -ms /bin/bash -p jusoro jusoro && \
    mkdir -p /app/jusoro-1.1.0-linux64-internet

COPY juso/jusoro-1.1.0-linux64-internet.tar /app/

RUN chown -R jusoro:jusoro /app/jusoro-1.1.0-linux64-internet

USER jusoro

RUN tar -xvf /app/jusoro-1.1.0-linux64-internet.tar -C /app/jusoro-1.1.0-linux64-internet/ && \
    chmod -R 755 /app/jusoro-1.1.0-linux64-internet && \
    rm -f /app/jusoro-1.1.0-linux64-internet.tar

COPY juso/jetty.xml /app/jusoro-1.1.0-linux64-internet/jusoro/server/etc/
COPY juso/startup.sh /app/jusoro-1.1.0-linux64-internet/jusoro/bin/

WORKDIR /app/jusoro-1.1.0-linux64-internet/jusoro/bin

EXPOSE 8983
CMD ["/app/jusoro-1.1.0-linux64-internet/jusoro/bin/startup.sh"]

