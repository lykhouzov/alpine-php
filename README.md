# alpine-php
Image for php 5.6 base on Alpine Linux

This image is configured to be used in stack of container which run Magento 1.x project
```
docker run -d --name php-fpm -p 9000:9000 / lykhouzov/alpine-php
```

And now you can connect to fpm using 9000 port.

Generally i have following dir structure

```
/path/to/projects/
                project1/
                project2/
                ...
                projectN/
```

So that, i need to map my projects' directory to the container

```
docker run -d --name php-fpm -p 9000:9000 -v /path/to/projects/:/var/www/html/ lykhouzov/alpine-php
```
