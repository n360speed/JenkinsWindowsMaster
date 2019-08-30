FROM mcr.microsoft.com/powershell:latest

ENV JENKINS_HOME='C:\Program Files (x86)\Jenkins'

WORKDIR /jenkins

RUN mkdir C:\Temp

RUN powershell -Command wget http://mirrors.jenkins-ci.org/windows-stable/latest -OutFile C:\\Temp\\jenkins.zip

RUN powershell -Command Unblock-File C:\Temp\jenkins.zip \
    && powershell -Command Expand-Archive C:\Temp\jenkins.zip -DestinationPath C:\Temp\Jenkins

VOLUME ${JENKINS_HOME}

CMD powershell -ExecutionPolicy Bypass -Command Import-Module C:\jenkins\InstallJenkins.psm1;  \
    InstallJenkins -JENKINS_HOME:${JENKINS_HOME} \
    && powershell -Command Get-Content  "${env:JENKINS_HOME}\jenkins.out.log" -Tail 100 -Wait

EXPOSE 8080

COPY . /jenkins
