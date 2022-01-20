# User guide
All necessary installations are managed by the Dockerfile provided. Launching the container only requires building the image and running it.  
Inside the project folder, issue the following commands:
* Build command :
```bash
docker build -t IMAGE_TAG .
```
* Run command :
```bash
docker run -it IMAGE_TAG
```
Once the container is run, it launches `script.sh` that sets your google account credentials, gives it necessary permissions and creates the cluster.

* To delete the cluster use the following command :
```bash
. delete.sh
```
* In case something went wrong and the docker container exited :

First, find the stopped container ID using the following command
```bash
docker ps -a
```
Secondly, restart the container
```bash
docker start <containerID>
```
Thirdly, start a Bash shell in the container
```bash
docker exec -it <containerID> bash
```
Lastly, run the following command to restore the environement variables
```bash
. export.sh
```
```diff
-To run scripts, make sure to leave a space between '.' and the name of the file.
```
