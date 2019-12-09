FROM alpine:3.10
MAINTAINER Zalando SE

RUN apk --no-cache upgrade && apk --no-cache add ca-certificates

# add Zalando CA bundle
ADD https://secure-static.ztat.net/ca/zalando-root.ca /usr/local/share/ca-certificates/zalando-root.crt
ADD https://secure-static.ztat.net/ca/zalando-service.ca /usr/local/share/ca-certificates/zalando-service.crt

# add AWS RDS CA bundle
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem /tmp/rds-ca/aws-rds-ca-bundle.pem
# split the bundle into individual certs (prefixed with xx)
# see http://blog.swwomm.com/2015/02/importing-new-rds-ca-certificate-into.html
RUN cd /tmp/rds-ca && cat aws-rds-ca-bundle.pem|awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert" n ""}' \
    && for CERT in /tmp/rds-ca/cert*; do mv $CERT /usr/local/share/ca-certificates/aws-rds-ca-$(basename $CERT).crt; done \
    && rm -rf /tmp/rds-ca \
    && update-ca-certificates

CMD ["/bin/sh"]
