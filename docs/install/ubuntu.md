## install soft
postgresql-9.5
memcached
redis-server
nodejs
imagemagick


>sudo apt-get install -y git \
                        libpq-dev \
                        postgresql-9.5 \
                        memcached/
                        redis-server/
                        nodejs/
                        imagemagick/



```
sudo -u postgres psql
CREATE USER "root" WITH CREATEDB PASSWORD '123123123';
create database "ran-dev" WITH OWNER="root";
```
