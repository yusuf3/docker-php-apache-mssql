FROM ubuntu:focal

RUN apt-get update -y \
    && ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && apt-get install -y \
        make \
        php-pear \
        curl \
        apache2 \
        php libapache2-mod-php \
        gnupg2 \
        graphviz aspell ghostscript clamav php7.4-pspell php7.4-curl php7.4-gd php7.4-intl \
        php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-ldap php7.4-zip php7.4-soap php7.4-mbstring php7.4-dev \
        && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
        && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
        && apt-get update \
        && ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql17 unixodbc-dev \
        && pecl install sqlsrv \
        && pecl install pdo_sqlsrv \
        && printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini \
        && printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini \
        && phpenmod sqlsrv pdo_sqlsrv \
        && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR /var/www/html

# COPY docker-apache/moodle.conf /etc/apache2/sites-available/

# RUN a2enmod php7.4 \
#     a2dismod mpm_event \
#     a2enmod mpm_prefork \
#     a2enmod rewrite \
    # a2ensite moodle.conf \
    # && a2dissite 000-default.conf \
    # && service apache2 restart 

CMD ["apachectl","-D","FOREGROUND"]
