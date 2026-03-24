Assignment

Task 1 – Basic Linux Setup

 
New user created use : sudo adduser shubham
Grant sudo access : sudo usermode -aG sudo shubham
I used -aG  to append the user to the specified group(s) without removing them from other groups. But I can also use -G now because user shubham is new user and newly created used is not added to any group by default. 

Install the following packages:
sudo apt install git
sudo apt install curl
sudo apt install htop
sudo apt install nginx
<img width="870" height="385" alt="image" src="https://github.com/user-attachments/assets/0872da71-a761-4e63-919a-ae76955b9546" />

we can also install then in one go by using the sudo apt install git curl htop nginx – y
since , i m using the AWS Ubuntu EC2 I use below commands to install docker 
•	sudo apt install apt-transport-https ca-certificates curl software-properties-common -y 
•	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
•	sudo add-apt-repository \
                    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -cs) \
                     stable"
•	sudo apt update
•	sudo apt install docker-ce -y
OS version 
 
IP address
 
Memory usage and Disk usage
 

Task 2 – Service Management

•	Start nginx and ensure it is enabled
sudo systemctl start nginx
sudo systemctl enable nginx
•	Show how you:
o	Check service status
sudo systemctl status nginx
o	Check which process is using a specific port
sudo lsof -i :80  OR sudo netstat -tulnp | grep :80

 















Task 3 – Docker

•	Run a simple web application using Docker
•	Share the Dockerfile
•	Expose the application on a port
•	Verify that the application is accessible via browser

App.py 
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return 'Hello from my side'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
  

Docker file 
FROM python:3-slim

WORKDIR /app
COPY app.py .

RUN pip install flask

CMD ["python", "app.py"]
   
 



Task 4 – Nginx Reverse Proxy
•	Configure nginx to forward traffic from port 80 to your application port
sudo nano /etc/nginx/sites-available/default
 
•	Reload nginx after configuration
sudo systemctl reload nginx
 
•	Verify that the application is accessible via nginx  http://13.201.123.84/
 
Task 5 – Troubleshooting

issue: "Application Not Opening" (Unknown Database Error)
•	The Problem: The Node.js application crashes immediately upon starting because the car_showroom database does not exist on the Amazon RDS instance, leading to an ER_BAD_DB_ERROR.

How to Resolve It:
1.	Install MySQL Client: Ensure the VM can communicate with the RDS instance by installing the client tool
sudo apt install mysql-client -y

2.	Create the Database Manually: Connect to the RDS endpoint and manually create the database schema that the application expects

mysql -h <YOUR_RDS_ENDPOINT> -u admin -pShubham11 -e "CREATE DATABASE IF NOT EXISTS car_showroom;"

3.	Verify Connection: Ensure the environment variables (DB_HOST, DB_NAME, etc.) are correctly exported in the terminal before starting the app.

4.	Seed the Inventory: Run the seed.js script to populate the tables so the application has data to display.



Task 6 – Basic Script

1. Creating the Script
nano check_system.sh

2. The Script Content
 

3. Making the Script Executable
chmod +x check_system.sh

4. Running and Verifying
./check_system.sh
 
Task 7 – Short Questions

1. Difference between Docker image and container
•	Docker Image: A read-only, static template that contains the application code, libraries, and dependencies required to run an application.
•	Docker Container: A live, running instance of an image. If the image is the "blueprint," the container is the actual "building" created from that blueprint. Containers are built with the help of image.
2. Difference between systemctl start and systemctl enable
•	systemctl start: Immediately starts a service for the current session, but it will not automatically start after a system reboot.
•	systemctl enable: Configures the service to start automatically whenever the system boots up, but it does not start the service immediately in the current session.
3. What is Nginx Reverse Proxy used for?
•	Nginx Reverse Proxy is used to sit in front of a web server and forward client requests to it. It is primarily used for security (hiding application ports), load balancing, and handling SSL termination. If needed, Nginx can also route traffic to different servers based on rules, balance the load across multiple servers, or terminate SSL so the backend doesn’t have to handle encryption.
4. How do you check which process is using a port in Linux?
•	You can use the lsof command (e.g., sudo lsof -i :8080) or the ss command (e.g., sudo ss -tulpn | grep :8080) to identify the Process ID (PID) and the name of the application using a specific port.



5. What is AWS EC2 used for?
•	AWS EC2 (Elastic Compute Cloud) provides scalable, on-demand virtual servers in the cloud. It allows users to run applications, manage storage, and configure networking and security without needing physical hardware.
6. What is Jenkins used for?
•	Jenkins is an open-source automation server used for Continuous Integration (CI) and Continuous Deployment (CD). It automates the parts of software development related to building, testing, and deploying, facilitating technical aspects of continuous delivery.
7. What is CodePipeline?
•	AWS CodePipeline is a fully managed continuous delivery service that helps you automate your release pipelines for fast and reliable application and infrastructure updates. It coordinates the flow of code from source (like GitHub) through build and deployment stages.


