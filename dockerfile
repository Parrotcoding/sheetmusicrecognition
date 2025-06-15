FROM openjdk:17

# Install Python + pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install Flask
RUN pip install flask flask-cors

# Copy app
WORKDIR /app
COPY . /app

# Download Audiveris
RUN curl -L -o audiveris.zip https://github.com/Audiveris/audiveris/releases/latest/download/audiveris.zip && \
    unzip audiveris.zip -d audiveris && rm audiveris.zip

EXPOSE 7860
CMD ["python3", "app.py"]
