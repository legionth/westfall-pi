FROM resin/rpi-raspbian:jessie

MAINTAINER Niels Theen <werwofl@googlemail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    php5 php5-pgsql php5-fpm php-apc php5-curl php5-cli \
    supervisor unzip wget nginx php5-gd \
    build-essential gcc git\
    curl \
    git-core \
    build-essential \
    gcc \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY / /var/www

RUN pip install pyserial
RUN git clone git://git.drogon.net/wiringPi
RUN cd wiringPi && ./build
CMD pip install wiringpi2

RUN git clone https://github.com/technion/lol_dht22 /lol_dht22_src
RUN cd lol_dht22_src && ./configure && make
RUN mv /lol_dht22_src/loldht /loldht && rm -Rf /lol_dht22_src

RUN git clone https://github.com/doceme/py-spidev
RUN cd py-spidev && python setup.py install


CMD addgroup gpio
CMD addgroup spiuser
CMD chown -R root:gpio /sys/class/gpio
CMD chown -R root:www-data /var/www/src/service/scripts/fetchMoistureInPercent.py
CMD chmod +x /var/www/src/service/scripts/fetchMoistureInPercent.py

CMD adduser www-data gpio
CMD adduser www-data spi
CMD adduser www-data i2c

WORKDIR /var/www

ADD conf/nginx.conf /etc/nginx/sites-available/led-control
RUN ln -s /etc/nginx/sites-available/led-control /etc/nginx/sites-enabled/led-control
RUN rm /etc/nginx/sites-enabled/default

ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf


EXPOSE 80

VOLUME /var/www

RUN chmod 666 /dev/spi*
