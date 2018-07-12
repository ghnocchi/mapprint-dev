# どのイメージを基にするか
FROM debian:stretch-slim

# 作成したユーザの情報
MAINTAINER ghnocchi <gs.nocchi+dockerhub@gmail.com>

# RUN: docker buildするときに実行される
RUN set -x && \
  echo "now building..." && \
  apt -y update && \
  apt install -y git && \
  apt install -y wget && \
  apt install -y gcc-6 autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev && \
  apt install -y libssl-dev
  

# ruby install 2.4.4
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile && \
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile && \
  . ~/.bash_profile && \
  rbenv install 2.4.4 && \
  rbenv global 2.4.4 && \
  rbenv exec gem install bundler && \
  rbenv rehash


# node install latest lts ver
RUN ["/bin/bash", "-c", " \
  wget -O - https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
  . ~/.bashrc && \
  nvm install v8.11.3 && \
  nvm alias default v8.11.3 \
  "]

RUN mkdir /app

# ポート4567を開ける
EXPOSE 4567
EXPOSE 35729

# CMD: docker runするときに実行される
#CMD echo "now running..."
#ENTRYPOINT su postgres -c "/usr/pgsql-10/bin/postgres -D /usr/local/pgsql/data > /usr/local/pgsql/data/postgresql.log 2>&1"

CMD /bin/bash