# GPU AWS Batch
FROM nvidia/cuda:10.0-devel-centos7

RUN set -x && \

# create working folder
mkdir /work
WORKDIR /work

# install developertools
RUN yum install -y epel-release bzip2 zip unzip rsync zsh ksh which nano jq && \
yum install -y python-pip && \
yum groupinstall -y "Development tools"

ENV PATH $PATH:/root/.local/bin

# install awscli
RUN pip install --upgrade pip && \
pip install awscli


ENV AWS_DEFAULT_OUTPUT=json
ENV AWS_DEFAULT_REGION=us-west-2
ENV BATCH_FILE_TYPE=script
ENV BATCH_FILE_S3_URL=s3://<bucket-name>/input/gpu_run.sh

ADD fetch_and_run.sh /usr/local/bin/fetch_and_run.sh
RUN chmod +x /usr/local/bin/fetch_and_run.sh
ENTRYPOINT ["/usr/local/bin/fetch_and_run.sh"]
