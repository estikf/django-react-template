
# Dockerized Django, Postgres, Celery, Nginx and RabbitMQ

This is a template project that can be used to start a new django project easily.



## Requirements
You need to have **Docker** engine and **Docker Compose** to run this project.

Check out these links for installing them:

https://docs.docker.com/engine/install/
https://docs.docker.com/compose/install/
    
## Starting the project

Clone the repository

```
git clone https://github.com/estikf/dockerized-django.git
```
Start using docker compose
```
cd dockerized-django/docker
docker compose up -d
```

Create a super user
```
docker exec -it api python manage.py createsuperuser
```
Visit your browser for admin panel
```
http://localhost/admin
```

Visit your browser for api endpoints
```
http://localhost/api
```

## Usage/Examples
Create a new django app
```python
cd dockerized-django/api
python manage.py startapp <your-app-name>
```
Start building your api endpoints!

