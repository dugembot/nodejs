# Docker multi-stage build

# 1. Building the App with Maven
FROM risingstack/alpine:3.3-v4.2.6-1.1.3
WORKDIR /app

COPY package.json package.json  
RUN npm install

# Just echo so we can see, if everything is there :)
RUN apk update \
	&& apk add --no-cache --update aria2 rclone bash \
	&& mkdir -p downloads front \
	&& wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.1.7/AriaNg-1.1.7.zip \
	&& unzip AriaNg-1.1.7.zip -d front \
	&& rm -rf AriaNg-1.1.7.zip

COPY . .

ENV PORT=8080
EXPOSE 8080

CMD ["bash", "init.sh"]
