FROM ruby:latest

LABEL \
	io.voxbox.build-date=${BUILD_DATE} \
	io.voxbox.name=rails-api \
	io.voxbox.vendor=voxbox.io \
    maintainer=matteo@voxbox.io \
	io.voxbox.vcs-url=https://github.com/matteolc/docker-rails-api.git \
	io.voxbox.vcs-ref=${VCS_REF} \
	io.voxbox.license=MIT

ARG APP_NAME
ARG ADMIN_SECRET
ARG USER_SECRET
ARG RAILS_ENV

ENV APP_HOME=app \
    APP_NAME=${APP_NAME:-app} \
    ADMIN_SECRET=${ADMIN_SECRET:-12345678} \
    USER_SECRET=${USER_SECRET:-12345678} \
    RAILS_ENV=${RAILS_ENV:-development}

RUN apt-get update && apt-get install -y \
  build-essential \
  sudo \
  curl \
  wget \
  git 

RUN gem install \
      bundler \
      rails \
      foreman \
      --no-rdoc --no-ri

ARG ROLLBAR_ACCESS_TOKEN
ARG DB_USER
ARG DB_SECRET
ARG DB_HOST
ARG GIT_USER_EMAIL
ARG GIT_USER_NAME

ENV DB_USER=${DB_USER:-$APP_NAME} \
    DB_SECRET=${DB_SECRET:-demo} \
    DB_HOST=${DB_HOST:-db} \
    GIT_USER_EMAIL=${GIT_USER_EMAIL:-"you@example.com"} \
    GIT_USER_NAME=${GIT_USER_NAME:-"Your Name"}     

WORKDIR ${APP_NAME}

RUN git config --global \
      user.email ${GIT_USER_EMAIL} && \
    git config --global \
      user.name ${GIT_USER_NAME}

RUN echo "ROLLBAR_ACCESS_TOKEN=${ROLLBAR_ACCESS_TOKEN}" > .env && \
    echo "ADMIN_SECRET=${ADMIN_SECRET}" >> .env && \
    echo "USER_SECRET=${USER_SECRET}" >> .env && \
    echo "DB_USER=${DB_USER}" >> .env && \
    echo "DB_SECRET=${DB_SECRET}" >> .env && \
    echo "DB_HOST=${DB_HOST}" >> .env

RUN rails new . \
    -m https://raw.github.com/matteolc/rails_api_template/master/rails_api_generator.rb \
    -d postgresql \
    --skip-yarn \
    --skip-action-cable \
    --skip-sprockets \
    --skip-spring \
    --skip-coffee \
    --skip-javascript \
    --skip-turbolinks \
    --skip-bundle \
    --api      



