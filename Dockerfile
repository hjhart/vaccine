FROM ruby:2.7.2-alpine AS builder
RUN apk add --no-cache \
  build-base libffi-dev \
  nodejs yarn tzdata \
  postgresql-dev postgresql-client zlib-dev libxml2-dev libxslt-dev readline-dev bash \
  #
  # For testing
  chromium chromium-chromedriver python3 python3-dev py3-pip \
  #
  # Nice-to-haves
  git vim \
  #
  # Fixes watch file issues with things like HMR
  libnotify-dev


RUN pip3 install -U selenium

FROM builder AS development

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV PATH /usr/src/app/bin:$PATH

# Install latest bundler
RUN bundle config --global silence_root_warning 1

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN gem install bundler:2.2.2
RUN bundle config without development
RUN bundle install --jobs 4

COPY . .

ENV PATH ./bin:$PATH

RUN ln -s /usr/bin/chromedriver /usr/local/bin/chromedriver

ENV DOCKER_LAND=true

CMD ["bin/whenever-cron"]
