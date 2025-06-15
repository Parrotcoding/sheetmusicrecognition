FROM debian:bullseye-slim

# Install Java, Python, and tools
RUN apt-get update && apt-get install -y \
  openjdk-17-jdk \
  python3 \
  python3-pip \
  curl \
  unzip

# Set Java path
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Create working directory
WORKDIR /app
COPY . .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Download Audiveris
RUN curl -L -o audiveris.zip https://github.com/Audiveris/audiveris/releases/latest/download/audiveris.zip && \
    unzip audiveris.zip -d audiveris && rm audiveris.zip

EXPOSE 7860
CMD ["python3", "app.py"]
