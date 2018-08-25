FROM fedora
MAINTAINER Ahmed ALAMI <ahmed.alami.fr@gmail.com>

RUN groupadd -r dejavu && useradd -r -g dejavu dejavu

# Pull in updates and install required libraries
RUN yum install python MySQL-python numpy scipy python-matplotlib portaudio-devel python-pip gcc -y
RUN yum localinstall https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
RUN yum install ffmpeg ffmpeg-devel -y
RUN yum clean all

# Install python dependencies
RUN pip install PyAudio
RUN pip install pydub
RUN pip install virtualenv
RUN pip install Flask

# Define the environment variables required for the image
ENV DEFAULT_CONFIG_FILE=/opt/dejavu/dejavu.cnf
ENV HOST="mysql"
ENV USER="dejavu"
ENV PASSWORD="dejavu"
ENV DB="dejavu"

ADD ./dejavu /opt/dejavu

RUN chown -R dejavu:dejavu /opt/dejavu

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8080

#RUN cd ./dejavu && ./test_dejavu.sh
