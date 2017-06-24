# -*- coding: utf-8 -*-


from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class User(db.Model):
    # ..
    __table_args__ = {
        'mysql_charset': 'utf8',
        'mysql_engine': 'InnoDB'
    }

    # @field id
    id = db.Column(
        db.Integer,
        primary_key=True
    )

    # @field username
    username = db.Column(
        db.String(length=30),
        nullable=False,
        unique=True
    )

    # @field password
    password = db.Column(
        db.String(length=128),
        nullable=False
    )

    # @field first_name
    first_name = db.Column(
        db.String(length=30)
    )

    # @field last_name
    last_name = db.Column(
        db.String(length=30)
    )

    # @field email
    email = db.Column(
        db.Unicode(length=255)
    )
