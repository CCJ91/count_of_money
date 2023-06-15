import collections
import sqlite3
from flask import Flask
from sqlite3 import Error
from ..Exceptions import DbFailedException

app = Flask(__name__)
app.config.from_pyfile("../../config.py")
# dbFile = app.config['DB_FILE']
dbFile = '../back/api/countOfMonet.db'


def get_all():
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT id, setting_name, status, setting_user_id FROM setting")
            dbData = cursor.fetchall()
            settings_list = collections.OrderedDict()
            for line in dbData:
                settings_list['id'] = line[0]
                settings_list['setting_name'] = line[1]
                settings_list['status'] = line[2]
                settings_list['setting_user_id'] = line[3]
            cursor.close()
            connection.cursor()
            return settings_list
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def get_by_user_id(user):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT id, setting_name, status FROM setting WHERE setting_user_id = ?", [user['id']])
            dbData = cursor.fetchall()
            settings = []
            for line in dbData:
                settings_list = collections.OrderedDict()
                settings_list['id'] = line[0]
                settings_list['setting_name'] = line[1]
                settings_list['status'] = line[2]
                settings.append(settings_list)
            cursor.close()
            connection.close()
            return settings
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def get_by_user_id_setting_name(user, setting_name):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT id, status FROM setting WHERE setting_user_id = ? AND setting_name = ?", [user['id'], setting_name])
            dbData = cursor.fetchall()
            settings_list = collections.OrderedDict()
            for line in dbData:
                settings_list['id'] = line[0]
                settings_list['setting_name'] = line[1]
                settings_list['status'] = line[2]
            cursor.close()
            connection.close()
            return settings_list
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def get_setting_anonyme():
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT id, setting_name, status FROM setting WHERE setting_user_id = ?", [1])
            db_data = cursor.fetchall()
            settings_list = []
            for line in db_data:
                setting = collections.OrderedDict()
                setting['id'] = line[0]
                setting['setting_name'] = line[1]
                setting['status'] = line[2]
                settings_list.append(setting)
            cursor.close()
            connection.close()
            return settings_list
        else:
            raise DbFailedException.DbFailedException
    except Error as e:
        print(e)


def add_setting_user(setting, user_id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("INSERT INTO setting(setting_name, status, setting_user_id) VALUES(?,?,?)", [setting['setting_name'], setting['status'], user_id]).fetchall()
            connection.commit()
            cursor.close()
            connection.close()
            return setting
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def update_setting(setting, user):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("UPDATE setting SET setting_name = ?, status = ?, setting_user_id = ? WHERE id = ?",
                           [setting['setting_name'], setting['status'], user['id'], setting['id']])
            connection.commit()
            cursor.close()
            connection.close()
            return setting
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def delete_setting(setting, user):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("DELETE FROM setting WHERE setting_user_id = ?", [user['id']])
            connection.commit()
            cursor.close()
            connection.close()
            return setting
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)
