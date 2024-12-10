FROM php:5.3-apache
COPY files /tmp/files/
RUN echo ZGViIGh0dHA6Ly9hcmNoaXZlLmRlYmlhbi5vcmcvZGViaWFuLyBqZXNzaWUgbWFpbiBjb250cmliIG5vbi1mcmVlCmRlYi1zcmMgaHR0cDovL2FyY2hpdmUuZGViaWFuLm9yZy9kZWJpYW4vIGplc3NpZSBtYWluIGNvbnRyaWIgbm9uLWZyZWUKZGViIGh0dHA6Ly9hcmNoaXZlLmRlYmlhbi5vcmcvZGViaWFuLXNlY3VyaXR5LyBqZXNzaWUvdXBkYXRlcyBtYWluIGNvbnRyaWIgbm9uLWZyZWUKZGViLXNyYyBodHRwOi8vYXJjaGl2ZS5kZWJpYW4ub3JnL2RlYmlhbi1zZWN1cml0eS8gamVzc2llL3VwZGF0ZXMgbWFpbiBjb250cmliIG5vbi1mcmVl |base64 -d > /etc/apt/sources.list && \
    apt-get update && \
    chown -R root:root /var/www/html/ && \
    chmod -R 755 /var/www/html && \
    mv /tmp/files/flag.sh / && \
    mv /tmp/files/start.sh / && \
    chmod +x /flag.sh /start.sh && \
    apt-get update && \
    apt-get remove libmysqlclient-dev -y --force-yes && \
    apt-get install libaio1 libnuma1 psmisc libmecab2 init-system-helpers redis-server -y --force-yes && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-common_5.7.29-1debian8_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-client_5.7.29-1debian8_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-client_5.7.29-1debian8_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-server_5.7.29-1debian8_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-server_5.7.29-1debian8_amd64.deb && \
    pecl install /tmp/files/redis-4.3.0.tar && \
    echo "extension=redis.so" >> /usr/local/lib/php.ini && \
    cp -f /tmp/files/redis.conf /etc/redis/redis.conf && \
    rm -rf /tmp/files && \
    rm -rf /var/lib/apt/lists/*
CMD /start.sh
