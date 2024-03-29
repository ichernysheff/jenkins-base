ARG     JENKINS_VERSION
FROM    jenkins/jenkins:${JENKINS_VERSION}

ARG     UID=1000
ARG     GID=1000
ARG     JENKINS_USER_HOME=/home/jenkins
ARG     JAVA_OPTIONS

ENV     _JAVA_OPTIONS=${JAVA_OPTIONS}
ENV     JENKINS_HOME=${JENKINS_USER_HOME}/data
ENV     COPY_REFERENCE_FILE_LOG=${JENKINS_USER_HOME}/copy_reference_file.log

USER    root
RUN     groupmod -g ${GID} jenkins \
        && usermod -u ${UID} -g ${GID} -d ${JENKINS_USER_HOME} jenkins \
        && chown -R ${UID} /usr/share/jenkins/ref

USER    jenkins
COPY    --chown=${UID}:${GID} plugins.txt ${JENKINS_HOME}/plugins.txt
RUN     jenkins-plugin-cli \
            --war /usr/share/jenkins/jenkins.war \
            --plugin-file ${JENKINS_HOME}/plugins.txt
COPY    --chown=${UID}:${GID} *secrets/* ${JENKINS_HOME}/secrets/
