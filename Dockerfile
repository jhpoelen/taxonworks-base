FROM phusion/passenger-ruby24:0.9.31
MAINTAINER Matt Yoder
ENV LAST_FULL_REBUILD 2018-05-10

# From Phusion
ENV HOME /root
RUN rm /etc/nginx/sites-enabled/default

# Update repos
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Until we move to update Ubuntu
RUN apt install wget
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# TaxonWorks dependancies
RUN apt-get update && \
      apt-get install -y locales software-properties-common \ 
      postgresql-client-10 \
      git gcc build-essential \
      libffi-dev libgdbm-dev libncurses5-dev libreadline-dev libssl-dev libyaml-dev zlib1g-dev libcurl4-openssl-dev \
      pkg-config imagemagick libmagickcore-dev libmagickwand-dev \
      libpq-dev libproj-dev libgeos-dev libgeos++-dev \
      tesseract-ocr \
      cmake \
      nodejs yarn && \
      apt clean && \ 
      rm -rf /var/lip/abpt/lists/* /tmp/* /var/tmp/* 

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV RAILS_ENV production

RUN echo 'gem: --no-rdoc --no-ri >> "$HOME/.gemrc"'
RUN gem update --system
