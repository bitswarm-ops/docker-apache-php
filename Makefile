all: php

php:
	docker build -t bitswarm/apache-php .
