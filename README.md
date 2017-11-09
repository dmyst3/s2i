1.	Create Project with docker file
               https://github.com/dmyst3/s2i

2.	Run the following commands to create a new build from the above repo
oc new-build https://github.com/dmyst3/s2i
3.	Run the following command below to create another build for the app

               oc new-build -i mulesoft --name=mule-app --binary=true
4.	Run the following command to start the app build and deploy a file

               oc start-build mule-app --from-file=mule-ci-1.0.0-SNAPSHOT.zip
