# Docker multi-stage build

# 1. Building the App with Maven
FROM node:lts-alpine
WORKDIR /app

COPY package.json ./
RUN npm install

# Just echo so we can see, if everything is there :)
RUN apk update \
	&& apk add --no-cache --update aria2 bash wget curl unzip \
	&& mkdir -p downloads front \
	&& curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \
	&& unzip rclone-current-linux-amd64.zip \
	&& mv rclone-*-linux-amd64/rclone /usr/bin/ \
	&& wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.1.7/AriaNg-1.1.7.zip \
	&& unzip AriaNg-1.1.7.zip -d front \
	&& rm -rf AriaNg-* rclone-*

COPY . .

ENV PORT=8080
EXPOSE 8080

CMD ["bash", "init.sh"]
