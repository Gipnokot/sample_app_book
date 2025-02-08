# Используем официальный образ Ruby в качестве базового образа
FROM ruby:3.4-slim

# Устанавливаем системные зависимости, включая пакеты разработки PostgreSQL
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    build-essential \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочий каталог
WORKDIR /app

# Копируем Gemfile и Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Устанавливаем зависимости Ruby
RUN bundle install

# Копируем код приложения
COPY . .

# Предварительная компиляция ресурсов (если необходимо)
RUN bundle exec rails assets:precompile

# Открываем порт (при необходимости измените)
EXPOSE 3000

# Запускаем приложение
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
