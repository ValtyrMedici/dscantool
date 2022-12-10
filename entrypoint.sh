#!/bin/sh
echo "hi"
if ["$DATABASE" = "postgresql"]
then
    echo "Waiting for postgresql..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 0.1
    done

    echo "postgresql started"
fi

python manage.py makemigrations
python manage.py migrate

exec "$@"
