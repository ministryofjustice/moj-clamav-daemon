FROM alpine:latest

# Important!  Update this no-op ENV variable when this Dockerfile is updated
# with the current date. It will force refresh of all of the base images and
# will prevent the package manager from using old cached versions when the
# Dockerfile is built.
ENV REFRESHED_AT=2017-05-08

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
COPY . /
RUN mkdir -p /var/lib/clamav
RUN chown clamav /var/lib/clamav

EXPOSE 3310

CMD ["/run.sh"]
