FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rails-tutorial
WORKDIR /rails-tutorial
COPY Gemfile /rails-tutorial/Gemfile
COPY Gemfile.lock /rails-tutorial/Gemfile.lock
RUN bundle install
COPY . /rails-tutorial
ENV RUBYOPT -EUTF-8

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
