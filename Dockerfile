FROM docker:1.8.3
MAINTAINER admin@acale.ph

ADD build/bin/pingpong /usr/bin/pingpong
RUN chmod +x /usr/bin/pingpong

EXPOSE 8080
ENTRYPOINT "/usr/bin/pingpong"
