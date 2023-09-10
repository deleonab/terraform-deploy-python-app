TASK
-------
HOW TO DRASTICALLY REDUCE THE SIZE OF YOUR DOCKER IMAGE

1. Create EC2 Instance
2. 

We shall use a basic FLASK APP which is written in Python to demonstrate how to achieve this

Our app concists of 2 files
myapp.py and requirements.txt


### requirements.txt
```
flask
```
### myapp.py
```
from flask import Flask
welcome = Flask(__name__)
@welcome.route("/")
def run():
    return "{\"message\": \" Welcome to DevOps Uncut\"}"
if __name__ == "__main__" :
    welcome.run(host="0.0.0.0", port = int("5000") , debug=True )
```

### Dockerfile
```
FROM python:3-alpine3.15
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python ./myapp.py
```