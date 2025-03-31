FROM ruby:3.2-alpine

# Install dependencies
RUN apk add --no-cache build-base sqlite-dev tzdata nodejs git yaml-dev

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

RUN bundle exec rails db:migrate || bundle exec rails db:setup

# Start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
# CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0"];