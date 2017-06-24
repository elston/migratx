# -*- coding: utf-8 -*-

import os


class ImproperlyConfigured(Exception):
    pass


def get_env_variable(var_name, allow_none=False):
    try:
        return os.environ[var_name]
    except KeyError:
        if allow_none is False:
            err_msg = "Set the %s environment variable" % var_name
            raise ImproperlyConfigured(err_msg)
        return None


class BaseConfig(object):

    # ...
    DEBUG = False
    TESTING = False

    # ...dir
    PROJECT_PATH = os.path.dirname(
        os.path.abspath(__file__)
    )

    # ...databases
    DB_USER = get_env_variable('DB_USER')
    DB_PASSWORD = get_env_variable('DB_PASSWORD')
    DB_NAME = get_env_variable('DB_NAME')
    DB_URL = get_env_variable('DB_URL')
    # ....
    SQLALCHEMY_DATABASE_URI = (
        'mysql://{db_user}:{db_password}@{db_url}:3306/{db_name}'
        '?charset=utf8').format(
            db_user=DB_USER,
            db_password=DB_PASSWORD,
            db_name=DB_NAME,
            db_url=DB_URL
    )


class DevConfig(BaseConfig):
    DEBUG = True
    TESTING = False


class TestConfig(BaseConfig):
    DEBUG = False
    TESTING = True


config = {
    "base": "config.BaseConfig",
    "dev": "config.DevConfig",
    "test": "config.TestConfig",
}


def init_app(app):
    # ...
    config_name = os.getenv('FLASK_CONFIGURATION', 'dev')
    app.config.from_object(config[config_name])
