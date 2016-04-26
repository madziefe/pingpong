FROM busybox:latest
MAINTAINER admin@acale.ph

ADD build/bin/pingpong /usr/bin/pingpong
RUN chmod +x /usr/bin/pingpong

EXPOSE 8080
ENTRYPOINT "/usr/bin/pingpong"