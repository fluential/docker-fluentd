# DOCKER-VERSION 1.1.2
# VERSION        0.1

FROM ubuntu:14.04
MAINTAINER Justin Plock <justin@plock.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y -q curl libcurl3 sudo ruby-dev
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh

ENV LD_PRELOAD /usr/lib/fluent/jemalloc/lib/libjemalloc.so
RUN ulimit -n 65536

# Install plugins
RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-riak
RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-kafka

EXPOSE 24224 8888

ENTRYPOINT ["/usr/sbin/td-agent"]
CMD ["-v"]
