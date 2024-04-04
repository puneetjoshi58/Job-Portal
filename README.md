# Job-Portal
A Job portal for companies to put out job requirements and for employees to look for one

# Dockerized
This application is now dockerized!

# Setup

Prerequisite to running the application :

1. Download and install AWS CLI

2. Download and install Docker

3. Download the docker-compose file

4. Login into Docker
    ```
    $ docker login
    
5. Login into AWS CLI
    ```
    $ aws configure
    ```
6. Use this Access String 
    ```
    $ aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 234194605782.dkr.ecr.ap-south-1.amazonaws.com 
    ```
    
    


To run the application use cmd 

```
$ docker-compose up
```
To stop the running application use cmd 

```
$ docker-compose down
```
To stop the running containers use cmds

```
$ docker ps -a
```
```
$ docker stop "Container ID"
```
```
$ docker rm "Container ID"
```
