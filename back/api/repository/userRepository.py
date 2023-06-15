import collections
import sqlite3

from sqlite3 import Error
from flask import Flask
from ..Exceptions import DbFailedException

app = Flask(__name__)
app.config.from_pyfile("../../config.py")
# dbFile = app.config['DB_FILE']
dbFile = '../back/api/countOfMonet.db'


# Fonction pour ajouter un utilisateur
def add_user(user_data):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("INSERT INTO user(username, email, password, oauth, profil) VALUES(?,?,?,?,?)",
                       [user_data['username'], user_data['email'], user_data['password'], user_data['oauth'],
                        user_data['profil']]).fetchall()
            connection.commit()
            cursor.close()
            connection.close()
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


# Fonction qui recherche le user via son email
def find_user_email(user_email):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT id, username, email, password, oauth, profil FROM user WHERE email=?", [str(user_email)])
            dbData = cursor.fetchall()
            userList = collections.OrderedDict()
            for line in dbData:
                userList['id'] = line[0]
                userList['username'] = line[1]
                userList['email'] = line[2]
                userList['password'] = line[3]
                userList['oauth'] = line[4]
                userList['profil'] = line[5]
            cursor.close()
            connection.close()
            return userList
        else:
            raise DbFailedException.DbFailedException()
    except sqlite3.OperationalError as e:
        raise e


# Fonction qui recherche le user par id
def find_user_id(id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT id, username, email, password, oauth, profil FROM user WHERE id=?", [id])
            dbData = cursor.fetchall()
            userList = collections.OrderedDict()
            for line in dbData:
                userList['id'] = line[0]
                userList['username'] = line[1]
                userList['email'] = line[2]
                userList['password'] = line[3]
                userList['oauth'] = line[4]
                userList['profil'] = line[5]
            cursor.close()
            connection.close()
            return userList
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def update_user(new_user, user):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("UPDATE user SET username = ?, email = ? WHERE id = ?",
                           (new_user['username'], new_user['email'], user['id']))
            connection.commit()
            cursor.close()
            connection.close()
            return new_user
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def update_password(password, user_id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("UPDATE user SET password = ? WHERE id = ?", (password, user_id))
            connection.commit()
            cursor.close()
            connection.close()
        else:
            raise DbFailedException.DbFailedException
    except Error as e:
        print(e)


def delete_user(id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("DELETE FROM user WHERE id = ?", [id])
            connection.commit()
            cursor.close()
            connection.close()
        else:
            raise DbFailedException.DbFailedException
    except Error as e:
        print(e)
