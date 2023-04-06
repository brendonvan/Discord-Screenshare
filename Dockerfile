FROM ubuntu:20.04

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl git unzip wget
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs
RUN npm i -g yarn

# Clone Repo
RUN git clone https://github.com/MainSilent/Discord-Screenshare.git
WORKDIR Discord-Screenshare
RUN yarn install
COPY .env .

# Install chrome 88
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 112.0.5615.49
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR
# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR
# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# Start Bot
RUN yarn start