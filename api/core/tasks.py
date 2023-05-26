from django_template.celery import app

@app.task
def hello_world():
    return "Hello, world!"

