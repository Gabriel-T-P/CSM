FROM ruby:3.4.2

RUN apt update -y
RUN apt install chromium watchman -y --no-install-recommends

WORKDIR /app

COPY Gemfile . 
COPY Gemfile.lock .

RUN bundle install

CMD [ "bin/setup" ]