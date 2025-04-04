FROM python:3

SHELL ["/bin/bash", "-c"]

ARG UID=1000
ARG GID=1000

RUN pip install --upgrade pip
# most important: add your python libs
RUN pip install --no-cache-dir notebook sklarpy copulas 

# add local user
RUN set -eux; \
    groupadd -g ${GID} jupyter; \
    useradd -u ${UID} -d /home/jupyter -m -s /bin/bash -g jupyter jupyter

# directory holding notebooks
ENV NB_HOME=/notebooks
RUN mkdir ${NB_HOME}
RUN chown jupyter:jupyter ${NB_HOME}

USER jupyter
WORKDIR ${NB_HOME}
EXPOSE 8000

CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--port=8000", "--no-browser" ]
