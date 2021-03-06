FROM python:3.9.1-alpine3.12

COPY requirements.txt /junk-drawer/requirements.txt

RUN /usr/local/bin/pip install --no-cache-dir --requirement /junk-drawer/requirements.txt

COPY . /junk-drawer

ENV APP_VERSION="2021.1" \
    FILE_UPLOAD_DIR="/file-uploads" \
    PASSWORD="" \
    PYTHONUNBUFFERED="1" \
    SECRET_KEY=""

ENTRYPOINT ["/usr/local/bin/python"]
CMD ["/junk-drawer/run.py"]

HEALTHCHECK CMD ["/usr/bin/wget", "--spider", "--quiet", "http://localhost:8080/"]
