# Docker multi-stage build

# 1. Building the App with Maven
FROM alpine:latest
WORKDIR /app

# Just echo so we can see, if everything is there :)
RUN apk update \
	&& apk add --no-cache --update aria2 rclone darkhttpd \
	&& mkdir -p downloads front \
	&& wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.1.7/AriaNg-1.1.7.zip \
	&& unzip AriaNg-1.1.7.zip -d front \
	&& rm -rf AriaNg-1.1.7.zip

COPY . .

EXPOSE 6800 8000 8080

CMD ["bash", "init.sh"]
