include $(PWD)/.env

build:
	docker build -t jenkins-base .

start:
	
	docker run --name jenkins \
	--env-file .env \
	--publish 8080:8080 \
	--volume ${JENKINS_DIR_LOCAL}:/home/jenkins/data/ \
	jenkins-base
stop:
	docker stop jenkins
