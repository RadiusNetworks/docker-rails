FROM ruby:2.3.0

# Install Gem depencencies:
#    postgres: libpq-dev
#    nokogiri: libxml2-dev libxslt1-dev
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install bundler foreman --no-rdoc --no-ri

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

CMD ["/bin/bash"]
