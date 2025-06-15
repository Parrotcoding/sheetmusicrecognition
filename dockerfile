FROM openjdk:17

# Install Python
RUN apt-get update && apt-get install -y python3 python3-pip curl unzip

# Set work directory
WORKDIR /app

# Copy all files
COPY . .

# Install Python deps
RUN pip3 install -r requirements.txt

# Download and unzip Audiveris
RUN curl -L -o audiveris.zip https://github.com/Audiveris/audiveris/releases/latest/download/audiveris.zip && \
    unzip audiveris.zip -d audiveris && rm audiveris.zip

EXPOSE 7860
CMD ["python3", "app.py"]
