FROM ruby:2.6.2

RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY . /app/
RUN gem install bundler
RUN bundle install

ENTRYPOINT [ "bin/rails" ]
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000
