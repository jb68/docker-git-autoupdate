FROM alpine

MAINTAINER Bertrand Roussel <broussel@sierrawireless.com>

RUN apk add --update --no-cache git dcron rsyslog netcat-openbsd

ADD entrypoint.sh /
ADD update.sh /

ENV VOLUME_PATH /git
VOLUME ["/git"]

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 10000

