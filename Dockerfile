FROM python:3.12-slim

RUN /usr/sbin/useradd --create-home --shell /bin/bash --user-group python

USER python
RUN /usr/local/bin/python -m venv /home/python/venv

COPY --chown=python:python requirements.txt /home/python/junk-drawer/requirements.txt
RUN /home/python/venv/bin/pip install --no-cache-dir --requirement /home/python/junk-drawer/requirements.txt

ENV APP_VERSION="2024.1" \
    FILE_UPLOAD_DIR="/home/python/file-uploads" \
    PATH="/home/python/venv/bin:${PATH}" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1" \
    SECRET_KEY="" \
    TZ="Etc/UTC"

WORKDIR /home/python/junk-drawer
ENTRYPOINT ["/home/python/venv/bin/python", "/home/python/junk-drawer/run.py"]

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.source="https://github.com/williamjacksn/junk-drawer"

COPY --chown=python:python run.py /home/python/junk-drawer/run.py
COPY --chown=python:python junk_drawer /home/python/junk-drawer/junk_drawer
