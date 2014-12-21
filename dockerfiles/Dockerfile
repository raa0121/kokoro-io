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
    libpq-dev

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git .ruby-build && \
    .ruby-build/install.sh && \
    rm -rf .ruby-build && \
    ruby-build 2.1.5 /usr/local

# Install bundler
RUN gem update --system && \
    gem install bundler --no-rdoc --no-ri

# Add application
RUN mkdir /app
WORKDIR /app
ADD ../Gemfile /app/Gemfile
RUN bundle install
ADD ../ /app

ENTRYPOINT ["bash", "-l", "-c"]

