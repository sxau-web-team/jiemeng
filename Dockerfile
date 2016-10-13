FROM alpine:edge

ENV TERM xterm

RUN apk add --update curl wget git \
  bash nginx ca-certificates \
  php5-fpm php5-json php5-zlib php5-xml php5-pdo php5-phar php5-openssl \
  php5-gd php5-mcrypt \
  php5-curl php5-openssl php5-json php5-dom php5-ctype && \
  apk add -u musl php5-cli && \
  mkdir -p /etc/nginx/conf.d && \
  rm -rf /var/cache/apk/*

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php/
ADD files/default.conf /etc/nginx/conf.d/
ADD files/run.sh /
ADD jiemeng /data/htdocs/

RUN chmod +x /run.sh

EXPOSE 80

WORKDIR /data/htdocs
VOLUME ["/data/htdocs", "/data/logs"]
CMD ["/run.sh"]
