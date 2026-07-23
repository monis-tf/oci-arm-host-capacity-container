FROM php:8.5-cli-alpine3.23 AS builder

RUN apk add --no-cache \
    git \
    unzip \
    curl

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . /app

RUN composer install --no-dev --no-interaction

FROM php:8.5-cli-alpine3.23 AS runner

WORKDIR /app

COPY --from=builder /app /app

CMD ["php", "index.php"]
