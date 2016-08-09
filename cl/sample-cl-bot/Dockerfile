FROM eshamster/cl-devel:1.3

# --- git settings --- #
RUN git config --global user.name "eshamster" && \
    git config --global user.email "hamgoostar@gmail.com"

# --- ssh settings --- #
ARG user=dev

ARG SSH_HOME=/home/${user}/.ssh
RUN mkdir ${SSH_HOME} && \
    chmod 700 ${SSH_HOME}

USER root
COPY id_rsa ${SSH_HOME}
COPY id_rsa.pub ${SSH_HOME}
RUN chown ${user}:${user} ${SSH_HOME}/* && \
    chmod 600 ${SSH_HOME}/*

# --- install mongodb --- #
COPY mongodb.repo /etc/yum/repos.d/
RUN yum install -y mongodb-org
RUN service mongod start

ARG MONGO_DB=/data/mongo
RUN mkdir -p ${MONGO_DB} && \
    chown ${user}:${user} ${MONGO_DB}
VOLUME ${MONGO_DB}

# --- --- #
USER ${user}
RUN ros run -e '(ql:quickload (list :dexador :clack :ningle))' -q
RUN ros install prove
RUN echo "export PATH=${HOME}/.roswell/bin:${PATH}" >> ${HOME}/.bashrc

RUN echo "echo \"start mongodb by 'mongo_start' command\"" >> ${HOME}/.bashrc
RUN echo "alias mongo_start='mongod --dbpath=${MONGO_DB} > /dev/null 2>&1 &'" >> ${HOME}/.bashrc
