# Linux Setup and Docker Assignment

---

## Task 1: Basic Linux Setup

Created a new user `shubham` with sudo access:

```bash
sudo adduser shubham
sudo usermod -aG sudo shubham
```
The -aG flag appends the user to the sudo group without removing existing groups

Installed required packages:

```bash
sudo apt update
sudo apt install git curl htop nginx -y
```

Installed Docker:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y
```

Verification commands:

```bash
cat /etc/os-release  or  hostnamectl
ifconfig             or curl ifconfig.me
free -h
df -h
```

**Screenshots:**

<img width="870" height="385" alt="image" src="https://github.com/user-attachments/assets/6602be71-fa15-45f7-b765-1a24e8245d15" />

<img width="780" height="408" alt="image" src="https://github.com/user-attachments/assets/621ec87d-004c-44a4-9ab5-206754e56b69" />

<img width="630" height="503" alt="image" src="https://github.com/user-attachments/assets/456e556e-ddf5-4600-9a64-f02ebd6525fc" />

<img width="825" height="143" alt="image" src="https://github.com/user-attachments/assets/9426f149-e29c-42c3-b95f-4ea2e72c10e7" />

---

## Task 2: Service Management

Started and enabled Nginx:

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

Checked service status:

```bash
sudo systemctl status nginx
sudo systemctl is-active nginx
sudo systemctl is-enabled nginx
```

Checked which process is using port 80:

```bash
sudo lsof -i :80
sudo netstat -tulnp | grep :80
```

**Screenshot:**

<img width="975" height="353" alt="image" src="https://github.com/user-attachments/assets/e8dd0da2-4709-491c-8346-042fcc35e4d1" />


---

## Task 3: Docker Web App

Created Flask app (`app.py`):

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return 'Hello from my side!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

Created `requirements.txt`:

```
flask
```

Dockerfile:

```dockerfile
FROM python:3-slim
WORKDIR /app
COPY app.py .
COPY requirements.txt .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

Build and run:

```bash
docker build -t myapp .
docker run -d -p 5000:5000 myapp
```

Verification:

```bash
docker ps
docker images
```

Access application:

```
http://<IP>:5000
```

**Screenshots:**

<img width="975" height="322" alt="image" src="https://github.com/user-attachments/assets/12e03bd3-a3a4-4385-bc0b-be7731276d65" />

<img width="975" height="496" alt="image" src="https://github.com/user-attachments/assets/ca07d9ce-b0ac-4656-b9c8-99c3a52a1341" />


---

## Task 4: Nginx Reverse Proxy

Updated Nginx config:

```bash
sudo nano /etc/nginx/sites-available/default
```

Configuration:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Reloaded Nginx:

```bash
sudo systemctl reload nginx
```

Access application:

```
http://13.201.123.84/
```

**Explanation:**
Nginx acts as a reverse proxy by forwarding requests from port 80 to the Flask app running on port 5000.

**Screenshots:**

<img width="975" height="210" alt="image" src="https://github.com/user-attachments/assets/6beb7164-888e-494e-8fad-974ef5a4f091" />

<img width="735" height="327" alt="image" src="https://github.com/user-attachments/assets/b57d8c52-552c-41d4-b8c1-f1620dcd6a71" />

<img width="780" height="414" alt="image" src="https://github.com/user-attachments/assets/5c020df1-7535-4ed5-ac4d-84b4e93fd61b" />


---

## Task 5: Troubleshooting

**Issue:**
Application failed with error `ER_BAD_DB_ERROR`

**Root Cause:**
Database `carshowroom` did not exist in AWS RDS

**Fix:**

```bash
sudo apt install mysql-client -y
mysql -h <RDS_ENDPOINT> -u admin -p -e "CREATE DATABASE IF NOT EXISTS carshowroom;"
```

Steps taken:

* Created missing database
* Verified environment variables
* Seeded database using script

**Verification:**
Application started successfully and worked without errors.



---

## Task 6: Basic Script

Created `checksystem.sh`:

nano checksystem.sh

```bash
#!/bin/bash

echo "Disk usage:"
df -h

echo "Memory usage:"
free -h

echo "Nginx status:"
systemctl is-active nginx

echo "App port (5000) listening?"
ss -tulpn | grep :5000
```

Made executable and ran:

```bash
chmod +x checksystem.sh

./checksystem.sh
```
<img width="690" height="365" alt="image" src="https://github.com/user-attachments/assets/cff69708-a41c-4a6d-b859-6c724d0ec434" />

<img width="690" height="261" alt="image" src="https://github.com/user-attachments/assets/ca5a78a3-79b1-4df4-9816-705d17be3b84" />

---

## Task 7: Short Questions

**1. Difference between Docker image and container**  
- Docker Image: A read-only, static template that contains the application code, libraries, and dependencies required to run an application.  
- Docker Container: A live, running instance of an image. If the image is the blueprint, the container is the actual building created from that blueprint. Containers are built with the help of image.

**2. Difference between systemctl start and systemctl enable**  
- `systemctl start`: Immediately starts a service for the current session, but it will not automatically start after a system reboot.  
- `systemctl enable`: Configures the service to start automatically whenever the system boots up, but it does not start the service immediately in the current session. 

**3. What is Nginx Reverse Proxy used for?**  
Nginx Reverse Proxy is used to sit in front of a web server and forward client requests to it. It is primarily used for security (hiding application ports), load balancing, and handling SSL termination. If needed, Nginx can also route traffic to different servers based on rules, balance the load across multiple servers, or terminate SSL so the backend doesn't have to handle encryption.


**4. How do you check which process is using a port in Linux?**  
You can use the `lsof` command e.g., `sudo lsof -i :8080` or the `ss` command e.g., `sudo ss -tulpn | grep :8080` to identify the Process ID (PID) and the name of the application using a specific port. 

**5. What is AWS EC2 used for?**  
AWS EC2 (Elastic Compute Cloud) provides scalable, on-demand virtual servers in the cloud. It allows users to run applications, manage storage, and configure networking and security without needing physical hardware.

**6. What is Jenkins used for?**  
Jenkins is an open-source automation server used for Continuous Integration (CI) and Continuous Deployment (CD). It automates the parts of software development related to building, testing, and deploying, facilitating technical aspects of continuous delivery.

**7. What is CodePipeline?**  
AWS CodePipeline is a fully managed continuous delivery service that helps you automate your release pipelines for fast and reliable application and infrastructure updates. It coordinates the flow of code from source (like GitHub) through build and deployment stages. [ppl-ai-file-upload.s3.amazonaws


