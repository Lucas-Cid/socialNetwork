FROM ruby:2.6.6

RUN apt-get update && apt-get install -y nodejs postgresql-client
RUN mkdir /vipy
WORKDIR /vipy
COPY Gemfile /vipy/Gemfile
COPY Gemfile.lock /vipy/Gemfile.lock
RUN bundle install
COPY . /vipy

# Adiciona um script para resolver o problema com o PID
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Inicia o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]