FROM php:7.3.3-apache-stretch
COPY --chown=www-data portfolio /var/www/html/
COPY ldap.conf /etc/ldap/ldap.conf
COPY locale.gen /etc/locale.gen
COPY portfolio/data /var/lib/openschulportfolio/data
COPY portfolio/conf /var/lib/openschulportfolio/conf
COPY portfolio/lib/plugins/ /var/lib/openschulportfolio/lib/plugins
COPY ldap_auth.php /var/lib/openschulportfolio/lib/plugins/authldap/auth.php
COPY ansible-lmn-configure.yml /root/lmn-configure.yml
COPY osp-setup /usr/bin/osp-setup
COPY osp-update /usr/bin/osp-update
COPY osp-entrypoint.sh /usr/bin/osp-entrypoint
RUN apt-get update
RUN apt-get install -y locales libldap2-dev ansible 
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
RUN docker-php-ext-install ldap
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*
COPY php.ini-production /usr/local/etc/php/php.ini
ENTRYPOINT ["/usr/bin/osp-entrypoint"]
