FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    bash \
    coreutils

COPY system_health.sh /app/system_health.sh

RUN chmod +x /app/system_health.sh

WORKDIR /app

CMD ["bash", "system_health.sh"]
