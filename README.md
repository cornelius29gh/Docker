# Docker
Docker and Docker compose


Docker files / images / containers + docker compose on Ubuntu Apche and Apache-Tomcat Webservers


docker commands used:

docker build -t tomcat-image "."
docker run -d -p 8080:8080 --name tomcat-container tomcat-image


docker build -t apache .
docker run -d -p 80:80 --name apache-container apache
