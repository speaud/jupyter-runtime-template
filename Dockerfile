# base image, see https://github.com/Paperspace/jupyter-docker-stacks/blob/master/base-notebook/README.md
FROM jupyter/scipy-notebook:python-3.8

# define global environment variables 
ENV GRANT_SUDO=yes
ENV JUPYTER_ENABLE_LAB=yes
ENV DEBIAN_FRONTEND=noninteractive
ENV CHOWN_HOME=yes
ENV CHOWN_HOME_OPTS='-R'
ENV NODE_OPTIONS="--experimental-modules"
ENV PYTHONPATH "${PYTHONPATH}:/home/app/src"

# set build process user
USER root

# apply general system updates and install base packages
RUN apt-get update -y \
    && apt-get install -y \
    libpq-dev \
    curl \
    golang-go \
    openjdk-11-jdk

# create empty directories to be used in later build steps
RUN mkdir -p \
    /home/app/src \
    /home/jovyan/notebooks \
    /home/jovyan/.local/share/jupyter/runtime \
    /home/jovyan/.local/share/jupyter/kernels/gophernotes

RUN chmod -R 777 /home

# override extension settings default values, see https://jupyterlab.readthedocs.io/en/stable/user/directories.html#settings
COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# install Node/JavaScript kernel
RUN cd /home/jovyan \
&& npm install --unsafe-perm -g ijavascript \
&& ijsinstall --install=global

# install TypeScript kernel
RUN cd /home/jovyan \
&& npm install --unsafe-perm -g itypescript \
&& its --install=global

# install Java kernel
RUN cd /home/ \
&& curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip > ijava-kernel.zip \
&& unzip ijava-kernel.zip -d ijava-kernel \
&& cd ijava-kernel \
&& python3 install.py --sys-prefix

# install Go kernel
RUN go install github.com/gopherdata/gophernotes@v0.7.5 \
    && cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/* ~/.local/share/jupyter/kernels/gophernotes/ \
    && chmod +w ~/.local/share/jupyter/kernels/gophernotes/kernel.json \
    && sed -i 's/gophernotes/\/home\/jovyan\/go\/bin\/gophernotes/g' ~/.local/share/jupyter/kernels/gophernotes/kernel.json

# change user, principle of least privilege (PoLP) 
USER jovyan

# install Python install packages/libraries
COPY requirements.txt /home/app/
RUN pip install -r /home/app/requirements.txt

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888

CMD ["start.sh", "jupyter", "lab", "--LabApp.token=''"]