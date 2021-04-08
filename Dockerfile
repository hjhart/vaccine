FROM ruby:2.7.2
RUN apt-get update && apt-get install -q -y git tar openssl xvfb chromium \
  firefox-esr libsqlite3-dev sqlite3

RUN cd /tmp && \
  wget https://chromedriver.storage.googleapis.com/2.39/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip -d /usr/local/bin && \
  rm -f chromedriver_linux64.zip

RUN cd /tmp && \
  wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz && \
  tar -xvzf geckodriver-v0.21.0-linux64.tar.gz -C /usr/local/bin && \
  rm -f geckodriver-v0.21.0-linux64.tar.gz

RUN apt install -q -y chrpath libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev && \
  cd /tmp && \
  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  mv phantomjs-2.1.1-linux-x86_64 /usr/local/lib && \
  ln -s /usr/local/lib/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin && \
  rm -f phantomjs-2.1.1-linux-x86_64.tar.bz2

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN gem install bundler:2.2.2
RUN bundle config without development
RUN bundle install --jobs 4

COPY . .

ENV PATH ./bin:$PATH

ENV DOCKER_LAND=true

RUN apt-get install cron -q -y 

CMD ["bin/whenever-cron"]
