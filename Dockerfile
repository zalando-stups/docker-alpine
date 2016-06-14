FROM alpine:3.4
MAINTAINER Zalando SE

# set locale
ENV LANG=en_US.UTF-8

RUN apk update && apk add curl ca-certificates coreutils

# add Zalando CA
ADD https://secure-static.ztat.net/ca/zalando-service.ca /usr/local/share/ca-certificates/zalando-service.crt
ADD https://secure-static.ztat.net/ca/zalando-root.ca /usr/local/share/ca-certificates/zalando-root.crt

# add AWS RDS CA bundle
RUN mkdir /tmp/rds-ca && \
    curl https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem > /tmp/rds-ca/aws-rds-ca-bundle.pem
# split the bundle into individual certs (prefixed with xx)
# see http://blog.swwomm.com/2015/02/importing-new-rds-ca-certificate-into.html
RUN cd /tmp/rds-ca && csplit -sz aws-rds-ca-bundle.pem '/-BEGIN CERTIFICATE-/' '{*}'
RUN for CERT in /tmp/rds-ca/xx*; do mv $CERT /usr/local/share/ca-certificates/aws-rds-ca-$(basename $CERT).crt; done

RUN update-ca-certificates
