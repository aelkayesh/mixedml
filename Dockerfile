
FROM python:3.6-stretch


# install build utilities
RUN apt-get update && \
 apt-get install -y gcc make apt-transport-https ca-certificates build-essential

# check our python environment
RUN python3 --version
RUN pip3 --version


RUN useradd -ms /bin/bash mixedu
USER mixedu
RUN mkdir -p /home/mixedu/mixedml
WORKDIR /home/mixedu/mixedml

ENV PATH="/home/mixedu/.local/bin:${PATH}"
# Installing python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all the files from the project’s root to the working directory
COPY src/ /home/mixedu/mixedml/src/

# Running Python Application
EXPOSE 8888

CMD ls -lah /home/mixedu/mixedml/
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
