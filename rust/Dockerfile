FROM eshamster/rust-devel:v0.2.0

RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh

ADD id_rsa /root/.ssh/
ADD id_rsa.pub /root/.ssh/

RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8
