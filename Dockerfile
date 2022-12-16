FROM jenkins/jenkins:2.382

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG=/jenkins/casc_configs/jenkins.yml
COPY plugins.txt /jenkins/plugins/plugins.txt
COPY ./jcasc/jenkins.yml /jenkins/casc_configs/jenkins.yml
RUN jenkins-plugin-cli -f /jenkins/plugins/plugins.txt
