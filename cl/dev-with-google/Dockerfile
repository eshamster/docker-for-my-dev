FROM eshamster/cl-devel2:latest

# --- git settings --- #
RUN git config --global user.name "eshamster" && \
    git config --global user.email "hamgoostar@gmail.com"

# --- ssh settings --- #
ARG user=root

ARG SSH_HOME=/root/.ssh
RUN mkdir ${SSH_HOME} && \
    chmod 700 ${SSH_HOME}

USER root
COPY id_rsa ${SSH_HOME}
COPY id_rsa.pub ${SSH_HOME}
RUN chown ${user}:${user} ${SSH_HOME}/* && \
    chmod 600 ${SSH_HOME}/*

# --- language settings --- #
# RUN localedef -vc -i ja_JP -f UTF-8 ja_JP.UTF-8

# --- --- #
USER ${user}
RUN ros install prove && \
    ros install qlot # && \
    # ros install ccl-bin && \
    # ros use ccl-bin
RUN echo "export PATH=${HOME}/.roswell/bin:${PATH}" >> ${HOME}/.bashrc
RUN echo "export LANG=ja_JP.UTF-8" >> ${HOME}/.bashrc

RUN apk add --no-cache openssl-dev

# --- Google --- #
COPY secret.json /root/.gcloud/secret.json
ENV GOOGLE_APPLICATION_CREDENTIALS /root/.gcloud/secret.json 
