#! /bin/sh

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ "${SCHEDULE}" = "**None**" ]; then
  sh backup.sh
else
  echo "${SCHEDULE} /bin/sh /backup.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root
fi

/usr/sbin/crond -f -d 8
