<h3>
If you want to run Jenkins on Windows container, you can use
this docker file.
</h3>

<h4>
Notes:

* Default JENKINS_HOME is C:\Program Files (x86)\Jenkins.
* The image downloads and builds the latest stable Jenkins release
  (which could take some time to download).
* Windows Powershell container is used, which makes the image
  a little big, but makes configuration easier.
* The JENKINS_HOME environment variable is set, but installer
  does not seem to use it, so it is passed as JENKINSDIR to the
  installer.
* Not currently planning to publish the container to Docker Hub,
  so use the Dockerfile as you like.
* This image just contains the Jenkins Master, which should be
  sufficient for testing.
</h4>

Clone repo to local work area and CD to directory:
```sh
git clone https://github.com/n360speed/JenkinsWindowsMaster.git
cd JenkinsWindowsMaster
```

You have a couple of options, not including any normal docker settings:
```sh
# Build the docker file
docker build --tag jenkins_windows_master .

# Try to pull latest image
docker build --tag jenkins_windows_master . --pull

# Force latest Jenkins update using no-cache
docker build --tag jenkins_windows_master . --no-cache

# Run the container with default configurations, with no exposed port
docker run -it jenkins_windows_master:latest

# Expose the Jenkins port (8080)
docker run -p 8080:8080 -it jenkins_windows_master:latest

# Change the Jenkins home directory to another location.
docker run -p 8080:8080 -e 'JENKINS_HOME=C:\JENKINS_HOME\Jenkins' -it jenkins_windows_master:latest

# If you want to mount a volume you can do something like below.
mkdir c:\temp\jenkinsmastervolume -Force
docker run -p 8080:8080 -e 'JENKINS_HOME=C:\JENKINS_HOME\Jenkins' -v=c:/Temp/jenkinsmastervolume:C:/JENKINS_HOME/Jenkins -it jenkins_windows_master:latest

```
