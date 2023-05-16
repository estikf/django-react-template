#!/bin/bash
python manage.py collectstatic --noinput
python manage.py makemessages --all
python manage.py compilemessages
until python manage.py migrate; do
    echo "Waiting for db to be ready..."
    sleep 1
done
gunicorn django_template.wsgi --bind 0.0.0.0:8000 --workers 4 --threads 4 --access-logfile '-' --error-logfile '-' --reload