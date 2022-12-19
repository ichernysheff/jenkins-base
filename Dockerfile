FROM    jenkins/jenkins:2.382

ARG     UID=3000
ARG     GID=3000
ARG     JENKINS_HOME_PATH=/home/jenkins

USER    root
RUN     groupmod -g ${GID} jenkins \
        && usermod -u ${UID} -g ${GID} -d ${JENKINS_HOME_PATH} jenkins \ 
        && chown -R ${UID} /usr/share/jenkins/ref

USER    ${UID}
ENV     JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV     CASC_JENKINS_CONFIG=${JENKINS_HOME_PATH}/casc_configs/jenkins.yml

ENV     COPY_REFERENCE_FILE_LOG=${JENKINS_HOME_PATH}/copy_reference_file.log
ENV     JENKINS_HOME=${JENKINS_HOME_PATH}/data

COPY    --chown=${UID}:${GID}  plugins.txt ${JENKINS_HOME_PATH}/data/plugins.txt
COPY    --chown=${UID}:${GID} ./jcasc/jenkins.yml ${CASC_JENKINS_CONFIG}

RUN     jenkins-plugin-cli \
            --war /usr/share/jenkins/jenkins.war \
            --plugin-file ${JENKINS_HOME_PATH}/data/plugins.txt
