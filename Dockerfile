FROM busybox:latest

ADD build/bin/pingpong /usr/bin/pingpong
EXPOSE 8080
ENTRYPOINT "/usr/bin/pingpong"
