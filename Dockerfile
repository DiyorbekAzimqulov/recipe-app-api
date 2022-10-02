# base image 
FROM python:3.9-alpine3.13 
LABEL MAINTAINER="Azimqulov Diyorbek"

ENV PYTHONUNBUFFERED 1  # python will run in unbuffered mode
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
# set working directory
WORKDIR /app 
# expose port 8000
EXPOSE 8000  

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \ 
    echo "DEV: ${DEV}" && \
    if [$DEV == true]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \ 
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"
# install dependencies

USER django-user
