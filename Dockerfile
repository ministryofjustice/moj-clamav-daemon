FROM alpine:latest

# Rsyslog is installed and started because neither clamd nor freshclam can
# write to /dev/stdout. They attempt to open it in append mode, which raises an
# error.
RUN apk --update --no-cache add \
  bash \
  bash-completion \
  clamav \
  clamav-libunrar \
  rsyslog

WORKDIR /
VOLUME /var/lib/clamav

COPY . /

EXPOSE 3310

CMD ["/run.sh"]
