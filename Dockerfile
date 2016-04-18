FROM busybox:latest

ARG APP_SRC

ADD $APP_SRC /usr/bin/pingpong
EXPOSE 8080
ENTRYPOINT "/usr/bin/pingpong"
