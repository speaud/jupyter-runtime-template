FROM jupyter/scipy-notebook:python-3.8

ENV GRANT_SUDO=yes
ENV JUPYTER_ENABLE_LAB=yes
ENV DEBIAN_FRONTEND=noninteractive
ENV CHOWN_HOME=yes
ENV CHOWN_HOME_OPTS='-R'
ENV NODE_OPTIONS="--experimental-modules"
ENV PYTHONPATH "${PYTHONPATH}:/home/app/src"

USER root

RUN apt-get update -y \
    && apt-get install -y \
    libpq-dev \
    curl \
    golang-go

RUN mkdir -p \
    /home/app/src \
    /home/jovyan/notebooks \
    /home/jovyan/.local/share/jupyter/runtime \
    /home/jovyan/.local/share/jupyter/kernels/gophernotes

RUN chmod -R 777 /home

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

RUN cd /home/jovyan \
    && npm install --unsafe-perm -g ijavascript \
    && ijsinstall --install=global

RUN go install github.com/gopherdata/gophernotes@v0.7.5 \
    && cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/* ~/.local/share/jupyter/kernels/gophernotes/ \
    && chmod +w ~/.local/share/jupyter/kernels/gophernotes/kernel.json \
    && sed -i 's/gophernotes/\/home\/jovyan\/go\/bin\/gophernotes/g' ~/.local/share/jupyter/kernels/gophernotes/kernel.json

USER jovyan

COPY requirements.txt /home/app/
RUN pip install -r /home/app/requirements.txt

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888

CMD ["start.sh", "jupyter", "lab", "--LabApp.token=''"]