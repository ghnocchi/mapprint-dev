# どのイメージを基にするか
FROM debian:stretch-slim

# 作成したユーザの情報
MAINTAINER ghnocchi <gs.nocchi+dockerhub@gmail.com>

# RUN: docker buildするときに実行される
RUN set -x && \
  echo "now building..." && \
  apt-get -y update && \
  apt-get install -y git && \
  apt-get install -y wget && \
  apt-get install -y gcc-6 autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev && \
  apt-get install -y libssl-dev
  

# ruby install 2.4.4
RUN ["/bin/bash", "-c", " \
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bash_profile && \
  echo 'eval \"$(rbenv init -)\"' >> ~/.bash_profile && \
  source ~/.bash_profile && \
  rbenv install 2.4.4 && \
  rbenv global 2.4.4 && \
  rbenv exec gem install bundler && \
  rbenv rehash \
  "]


# node install latest lts ver
RUN ["/bin/bash", "-c", " \
  wget -O - https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
  source ~/.bashrc && \
  nvm install v8.11.3 && \
  nvm alias default v8.11.3 \
  "]

COPY entrypoint.sh .

RUN mkdir /app

# ポート4567を開ける
EXPOSE 4567
EXPOSE 35729

# CMD: docker runするときに実行される
#CMD echo "now running..."
ENTRYPOINT /bin/bash /entrypoint.sh

#CMD /bin/bash
