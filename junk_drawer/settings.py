import os
import pathlib


class Settings:

    file_upload_dir: pathlib.Path
    log_format: str
    log_level: str
    password: str
    secret_key: str
    version: str

    def __init__(self):
        self.file_upload_dir = pathlib.Path(os.getenv('FILE_UPLOAD_DIR'))
        self.log_format = os.getenv('LOG_FORMAT', '%(levelname)s [%(name)s] %(message)s')
        self.log_level = os.getenv('LOG_LEVEL', 'INFO')
        self.password = os.getenv('PASSWORD')
        self.secret_key = os.getenv('SECRET_KEY')
        self.version = os.getenv('APP_VERSION', 'unknown')
