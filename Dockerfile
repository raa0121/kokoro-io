FROM ubuntu

# Install basic dev tools
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev \
    \
    sqlite3 \
    libsqlite3-dev \
    \
    libpq-dev \
    \
    ruby2.3 \
    ruby2.3-dev

# Install bundler
RUN gem update --system && \
    gem install bundler

# Add application
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/
RUN bundle install
ADD . /app

ENTRYPOINT ["bash", "-l", "-c"]
