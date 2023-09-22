[![CircleCI](https://dl.circleci.com/status-badge/img/gh/khangnv/DevOps_Microservices/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/khangnv/DevOps_Microservices/tree/master)

## Project Overview

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API.

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:

- Test your project code using linting
- Complete a Dockerfile to containerize this application
- Deploy your containerized application using Docker and make a prediction
- Improve the log statements in the source code for this application
- Configure Kubernetes and create a Kubernetes cluster
- Deploy a container using Kubernetes and make a prediction
- Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

## Setup the Environment

- Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv.

```bash
python -m pip install --user virtualenv
# You should have Python 3.7 available in your host.
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .devops
python -m virtualenv --python='C:\Users\BABY\AppData\Local\Programs\Python\Python37' .devops
source .devops/bin/activate
```

- Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone: `python app.py`
2. Run in Docker: `./run_docker.sh`
3. Run in Kubernetes: `./run_kubernetes.sh`

### Kubernetes Steps

- Setup and Configure Docker locally
- Setup and Configure Kubernetes locally
- Create Flask app in Container
- Run via kubectl

# MYSELF GUIDELINE

## Setup python and pip

Add to PATH environment:
C:\Users\BABY\AppData\Local\Programs\Python\Python37
C:\Users\BABY\AppData\Local\Programs\Python\Python37\Scripts
Then restart.

## Use Bash Shell

`#!/usr/bin/env bash`

## Go to the main folder

`cd DevOps_Microservices`

## Create and activate a new environment

`python -m pip install --user virtualenv`
`python -m virtualenv --python='C:\Users\BABY\AppData\Local\Programs\Python\Python37' .devops`

`python -m venv ~/.devops`
`source ~/.devops/Scripts/activate`

## `make install`

NOTE for local: `pip install -r requirements.txt --user`

Install dependencies by using makefile

## `run_docker.sh`

- `docker build --tag=project3 .`: Builds a Docker image in the current dictionary with name 'project3', tag 'latest'
- `docker images list`: Lists all the Docker images available on my system.
- `docker run -p 8000:80 project3`: Runs a Docker container with above built image 'project3'. Maps port 8000 on my host machine to port 80 inside the container. Access http://localhost:8000 via browser. It will simply display 'Sklearn Prediction Home'.

## `make_prediction.sh`

- `POST http://localhost:$PORT/predict`: Uses curl command to call '/predict' API. Then get the output of prediction.

## `upload_docker.sh`

- Run this script on time after `run_docker.sh`.

- `dockerpath="khangnv09/project3"`: Assigns 'khangnv09/project3' to 'dockerpath' variable.
- `echo "Docker ID and Image: $dockerpath"`: Prints a message indicating the Docker ID and Image that will be used in next steps.
- `docker login`: Logs in to the Docker Hub account, enabling to push images to the Docker Hub repository.
- `docker image tag project3 $dockerpath`: Tags the local built Docker image 'project3' with the specified 'dockerpath'.
- `docker push $dockerpath`: Pushes the tagged Docker image to the specified Docker Hub repository.

## Setup local Kubernetes

- `minikube start`: Starts the local cluster.

## `run_kubernetes.sh`

- `dockerpath="khangnv09/project3"`: Assigns the Docker image path to the variable 'dockerpath' value is the Docker Hub repository 'khangnv2/project3'.
- `kubectl run project3 --image=$dockerpath --port=80 --labels "app=project3"`: Uses command 'kubectl' to deploy a pod in a Kubernetes cluster with deployment name 'project3' and uses docker image 'khangnv09/project3' for the pod.
- `kubectl get pods`: Lists the pods in the Kubernetes cluster.
- `kubectl port-forward project3 8000:80`: Sets up port forwarding, allowing users to access the pod's port 80 on their local machine's port 8000. By this way, when they access `http://localhost:8000` in their web browser, the traffic will be forwarded to the pod's port 80, where the Flask application is running.

## Makefile

This file is used to automate the setup, installation of dependencies, testing, and linting processes for a project. It provides convenient commands that developers can use to perform common tasks without remembering the exact commands required.

- `setup`: This target is responsible for setting up the project environment. It creates a Python virtual environment using `python3.7 -m venv ~/.devops`. This is a common practice to isolate project dependencies from the system-wide Python installation.
- `install`: This target installs project dependencies specified in the `requirements.txt` file. It uses the `pip install` command to upgrade `pip` and install the required packages.
- `test`: This target is intended for running tests on the project. In the example, it contains comments showing how additional tests could be added, like running tests with `pytest` or testing Jupyter notebooks using `nbval`.
- `lint`: This target performs linting checks on the project files. It uses two linters:
  - `hadolint` to lint the Dockerfile. `hadolint` is a linter for Dockerfiles, and it helps ensure best practices in Dockerfile creation.
  - `pylint` to lint the Python source code. `pylint` is a widely used Python linter that checks for code quality and coding style.
- `all`: This is the default target that developers can run with the `make` command without specifying a target explicitly. It combines the `install`, `lint`, and `test` targets. This way, you can quickly run all the necessary steps to prepare, lint, and test the project.

## Delete Cluster

- `minikube delete`: Cleans up resources and delete the kubernetes cluster.
- `minikube stop`: Pauses the work and save the cluster state.
