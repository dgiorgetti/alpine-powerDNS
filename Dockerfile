FROM alpine:3.7
LABEL maintainer="dgiorgetti@vistaprint.com"

EXPOSE 53/tcp 53/udp 32000
WORKDIR /pdns
ADD init.sql .
ADD start.sh .

RUN apk --update --no-cache add pdns pdns-backend-sqlite3 && \
    rm /etc/pdns/pdns.conf &&\
    mkdir -p /var/empty/var/run/ &&\
    chmod +x /pdns/start.sh

CMD ["/pdns/start.sh"]
