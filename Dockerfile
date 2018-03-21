# Latest version of centos
FROM centos:7

LABEL Maintainer="Wallace Tan <wallace_tan@tech.gov.sg>" \
      Description="Tunnel over HTTP proxy container with socat"

RUN  yum update -y && \
    yum install -y socat net-tools && \
    yum install -y openssh-clients bash openssl && \
    yum install -y redis && \
    yum clean all
