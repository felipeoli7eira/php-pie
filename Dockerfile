FROM php:8.4-cli-alpine

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

COPY --from=ghcr.io/php/pie:bin /pie /usr/bin/pie

RUN apk --update --no-cache add \
    git make autoconf build-base linux-headers librdkafka-dev

WORKDIR /app
COPY . .

EXPOSE 8000
CMD ["php", "-S", "0.0.0.0:8000", "-t", "/app"]
