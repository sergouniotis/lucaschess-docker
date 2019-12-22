FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git sudo apt-utils

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN	apt-get install -y python-pip \
	python-dev \
	python-qt4 \
	python-pyaudio

RUN pip install setuptools && \
	pip install psutil && \
	pip install chardet && \
	pip install 'python-chess<0.24' && \
	pip install Pillow && \
	pip install PhotoHash && \
	pip install Cython && \
	pip install scandir    

USER developer
ENV HOME /home/developer	

RUN cd ${HOME} && git clone https://github.com/lukasmonk/lucaschess.git lucaschess

WORKDIR /home/developer/lucaschess

RUN chmod -R 755 *
RUN chmod -R +x *

RUN sed -i 's/LCEngine2.so/LCEngine4.so/' LCEngine/xcython_linux.sh

RUN cd LCEngine/irina && ./xmk_linux.sh

RUN cd LCEngine && ./xcython_linux.sh

ENV LD_LIBRARY_PATH /home/developer/lucaschess/Engines/Linux64/_tools

RUN chmod +x -R Engines/Linux64/

USER root
RUN apt-get install -y stockfish
User developer

RUN ln -s /usr/games/stockfish ${HOME}/stockfish.exe

ENTRYPOINT ["python2.7", "Lucas.py"]
