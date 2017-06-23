#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ..
from flask import Flask
app = Flask(__name__)

# ...config
import config
config.init_app(app)

# ..
from models import db
from flask_migrate import Migrate
migrate = Migrate(app, db)

# ...
from flask_script import Manager
from flask_migrate import MigrateCommand
manager = Manager(app)
manager.add_command('db', MigrateCommand)

# ...
if __name__ == '__main__':
    manager.run()
