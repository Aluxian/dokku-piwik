#!/bin/bash

while /bin/true; do
  php /app/vendor/piwik/piwik/console core:archive
  sleep 3600
done
