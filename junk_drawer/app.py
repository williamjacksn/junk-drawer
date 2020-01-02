import datetime
import flask
import junk_drawer.settings
import logging
import pathlib
import sys
import uuid
import waitress
import werkzeug.middleware.proxy_fix
import werkzeug.utils

settings = junk_drawer.settings.Settings()

app = flask.Flask(__name__)
app.wsgi_app = werkzeug.middleware.proxy_fix.ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_port=1)

app.secret_key = settings.secret_key


@app.route('/', methods=['GET', 'POST'])
def index():
    if flask.session.get('signed-in'):
        if flask.request.method == 'GET':
            return flask.render_template('upload-file.html')
        file = flask.request.files.get('file')
        filename = werkzeug.utils.secure_filename(file.filename)
        ext = pathlib.Path(filename).suffix
        u = str(uuid.uuid4())[:8]
        filename = f'{datetime.datetime.utcnow():%Y-%m-%d-%H%M%S}-{u}{ext}'
        file.save(str(settings.file_upload_dir / filename))
        return flask.redirect(flask.url_for('index'))
    return flask.render_template('sign-in.html')


@app.route('/sign-in', methods=['POST'])
def sign_in():
    password = flask.request.values.get('password')
    if password == settings.password:
        flask.session['signed-in'] = True
    return flask.redirect(flask.url_for('index'))


def main():
    logging.basicConfig(format=settings.log_format, level=logging.DEBUG, stream=sys.stdout)
    app.logger.debug(f'junk-drawer {settings.version}')
    if settings.log_level != 'DEBUG':
        app.logger.debug(f'Changing log level to {settings.log_level}')
    logging.getLogger().setLevel(settings.log_level)
    waitress.serve(app, ident=None)
