#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ..
from flask import Flask
from flask_script import Manager
from flask_migrate import (
    Migrate,
    MigrateCommand,
)

# ...
import config
from models import db

app = Flask(__name__)

# config
config.init_app(app)

# migrate
migrate = Migrate(app, db)

# manager
manager = Manager(app)
manager.add_command('db', MigrateCommand)

# ...
if __name__ == '__main__':
    manager.run()
