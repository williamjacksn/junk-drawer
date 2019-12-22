FROM python:3.8.0-alpine3.10

COPY requirements.txt /junk-drawer/requirements.txt

RUN /usr/local/bin/pip install --no-cache-dir --requirement /junk-drawer/requirements.txt

COPY . /junk-drawer

ENV APP_VERSION="2019.2" \
    FILE_UPLOAD_DIR="/file-uploads" \
    PASSWORD="" \
    PYTHONUNBUFFERED="1" \
    SECRET_KEY=""

ENTRYPOINT ["/usr/local/bin/python"]
CMD ["/junk-drawer/run.py"]
