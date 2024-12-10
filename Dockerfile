FROM php:5.3-apache
COPY files /tmp/files/
RUN chown -R root:root /var/www/html/ && \
    chmod -R 755 /var/www/html && \
    mv /tmp/files/flag.sh / && \
    mv /tmp/files/start.sh / && \
    chmod +x /flag.sh /start.sh && \
    sed -i 's/http.debian.net/mirrors.aliyun.com/g' /etc/apt/sources.list && \
	  sed -i '/security/d' /etc/apt/sources.list && \
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
