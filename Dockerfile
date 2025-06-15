# Use slim Debian as a base for Python and Java setup
FROM debian:bullseye-slim

# Install Java, Python, and required tools
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    curl \
    unzip \
    && apt-get clean

# Set Java home environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Set working directory inside the container
WORKDIR /app

# Copy all files from the GitHub repo
COPY . .

# Install Python dependencies for Flask API
RUN pip3 install -r requirements.txt

# Download and extract a specific version of Audiveris
RUN curl -L -o audiveris.zip https://github.com/Audiveris/audiveris/releases/download/5.3.2/Audiveris-5.3.2.zip && \
    unzip audiveris.zip -d audiveris && rm audiveris.zip

# Expose the port used by Flask
EXPOSE 7860

# Run the app
CMD ["python3", "app.py"]
