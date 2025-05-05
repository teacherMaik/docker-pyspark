FROM jupyter/base-notebook

# Install Java 8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk-headless && \
    apt-get clean

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

FROM jupyter/all-spark-notebook

# Switch to root to install packages
USER root

# Install extra Python packages
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Switch back to default user (important for Jupyter permissions)
USER $NB_UID

WORKDIR /home/jovyan/work
