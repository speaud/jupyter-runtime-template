FROM jupyter/scipy-notebook:python-3.8

ENV GRANT_SUDO=yes
ENV JUPYTER_ENABLE_LAB=yes
ENV DEBIAN_FRONTEND=noninteractive
ENV CHOWN_HOME=yes
ENV CHOWN_HOME_OPTS='-R'
ENV NODE_OPTIONS="--experimental-modules"

USER root

RUN apt-get update -y
RUN apt-get install -y libpq-dev curl golang-go

ENV PYTHONPATH "${PYTHONPATH}:/home/app/src"
RUN mkdir -p /home/app/src
RUN mkdir -p /home/jovyan/notebooks
RUN chmod 775 /home/jovyan /home/app /home/jovyan/notebooks

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

RUN mkdir -p /home/jovyan/.local/share/jupyter/runtime \
    && chown -R jovyan /home/jovyan/.local \
    && chown 777 /home/jovyan/.local \
    && mkdir -p /usr/local/share/jupyter \
    && chown -R jovyan /usr/local/share/jupyter \
    && chown 777 /usr/local/share/jupyter

RUN cd /home/jovyan \
    && npm install --unsafe-perm -g ijavascript itypescript \
    && ijsinstall --install=global \
    && its --install=global

RUN go install github.com/gopherdata/gophernotes@v0.7.5
RUN mkdir -p /home/jovyan/.local/share/jupyter/kernels/gophernotes/
RUN cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/* ~/.local/share/jupyter/kernels/gophernotes/
RUN chmod +w ~/.local/share/jupyter/kernels/gophernotes/kernel.json
RUN sed -i 's/gophernotes/\/home\/jovyan\/go\/bin\/gophernotes/g' ~/.local/share/jupyter/kernels/gophernotes/kernel.json

USER jovyan

COPY requirements.txt /home/app/
RUN pip install -r /home/app/requirements.txt

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888

CMD ["start.sh", "jupyter", "lab", "--LabApp.token=''"]