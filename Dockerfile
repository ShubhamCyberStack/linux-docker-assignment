FROM python:3-slim
WORKDIR /app
COPY app.py .
RUN pip install flask
CMD ["python", "app.py"]
