Assignment

Task 1 – Basic Linux Setup
<img width="870" height="385" alt="image" src="https://github.com/user-attachments/assets/cd6d1f87-ad9f-48d6-ac6d-fd4be39b53e0" />

New user created use : sudo adduser shubham
Grant sudo access : sudo usermode -aG sudo shubham
I used -aG  to append the user to the specified group(s) without removing them from other groups. But I can also use -G now because user shubham is new user and newly created used is not added to any group by default. 

Install the following packages:
sudo apt install git
sudo apt install curl
sudo apt install htop
sudo apt install nginx


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
 <img width="780" height="408" alt="image" src="https://github.com/user-attachments/assets/a3ae4398-7cca-41be-9b16-45464cacba3f" />

IP address
 <img width="630" height="503" alt="image" src="https://github.com/user-attachments/assets/09df8af1-39e9-4dff-a163-e01409ea3ad9" />

Memory usage and Disk usage
 <img width="825" height="143" alt="image" src="https://github.com/user-attachments/assets/60d9bc9d-2a9a-4798-860b-05abbd392989" />


Task 2 – Service Management

•	Start nginx and ensure it is enabled
sudo systemctl start nginx
sudo systemctl enable nginx
•	Show how you:
o	Check service status
sudo systemctl status nginx
o	Check which process is using a specific port
sudo lsof -i :80  OR sudo netstat -tulnp | grep :80
<img width="975" height="353" alt="image" src="https://github.com/user-attachments/assets/43732ae9-90f1-4331-8bf0-f5b89310857d" />


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
 <img width="975" height="322" alt="image" src="https://github.com/user-attachments/assets/d163d1f8-1ff4-4166-93a3-b080f632f7b0" />
<img width="975" height="496" alt="image" src="https://github.com/user-attachments/assets/c7380da9-584f-44d3-a01e-211fc39e4556" />




Task 4 – Nginx Reverse Proxy
•	Configure nginx to forward traffic from port 80 to your application port
sudo nano /etc/nginx/sites-available/default
 <img width="975" height="210" alt="image" src="https://github.com/user-attachments/assets/32f52ede-857b-46d1-9bcd-9a195272b314" />

•	Reload nginx after configuration
sudo systemctl reload nginx
 <img width="735" height="327" alt="image" src="https://github.com/user-attachments/assets/907dd79b-0b51-47b3-9760-83e8b4fc463a" />

•	Verify that the application is accessible via nginx  http://13.201.123.84/
 <img width="735" height="327" alt="image" src="https://github.com/user-attachments/assets/07b85a18-8635-4d72-ae04-582acd7ff470" />

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
 <img width="690" height="365" alt="image" src="https://github.com/user-attachments/assets/029d73bd-1c45-4309-a1b2-adfb54089559" />


3. Making the Script Executable
chmod +x check_system.sh

4. Running and Verifying
./check_system.sh
 <img width="690" height="261" alt="image" src="https://github.com/user-attachments/assets/6c0a55be-bd31-4416-a881-5bb986daad50" />

Task 7 – Short Questions

1. Difference between Docker image and container
•	Docker Image: A read-only, static template that contains the application code, libraries, and dependencies required to run an application.
•	Docker Container: A live, running instance of an image. If the image is the "blueprint," the container is the actual "building" created from that blueprint. Containers are built with the help of image.

3. Difference between systemctl start and systemctl enable
•	systemctl start: Immediately starts a service for the current session, but it will not automatically start after a system reboot.
•	systemctl enable: Configures the service to start automatically whenever the system boots up, but it does not start the service immediately in the current session.

4. What is Nginx Reverse Proxy used for?
•	Nginx Reverse Proxy is used to sit in front of a web server and forward client requests to it. It is primarily used for security (hiding application ports), load balancing, and handling SSL termination. If needed, Nginx can also route traffic to different servers based on rules, balance the load across multiple servers, or terminate SSL so the backend doesn’t have to handle encryption.
5. How do you check which process is using a port in Linux?
6. 
•	You can use the lsof command (e.g., sudo lsof -i :8080) or the ss command (e.g., sudo ss -tulpn | grep :8080) to identify the Process ID (PID) and the name of the application using a specific port.

7. What is AWS EC2 used for?
•	AWS EC2 (Elastic Compute Cloud) provides scalable, on-demand virtual servers in the cloud. It allows users to run applications, manage storage, and configure networking and security without needing physical hardware.

9. What is Jenkins used for?
•	Jenkins is an open-source automation server used for Continuous Integration (CI) and Continuous Deployment (CD). It automates the parts of software development related to building, testing, and deploying, facilitating technical aspects of continuous delivery.

11. What is CodePipeline?
•	AWS CodePipeline is a fully managed continuous delivery service that helps you automate your release pipelines for fast and reliable application and infrastructure updates. It coordinates the flow of code from source (like GitHub) through build and deployment stages.


