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
            cursor.execute("SELECT id, crypto_name, symbole, crypto_id FROM crypto")
            db_data = cursor.fetchall()
            crypto_list = []
            for line in db_data:
                list_temp = collections.OrderedDict()
                list_temp['id'] = line[0]
                list_temp['crypto_name'] = line[1]
                list_temp['symbole'] = line[2]
                list_temp['crypto_id'] = line[3]
                crypto_list.append(list_temp)
            cursor.close()
            return crypto_list
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)
    finally:
        connection.close()


def get_crypto(crypto):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT crypto_name FROM crypto WHERE crypto_id = ?", [crypto['crypto_id']])
            db_data = cursor.fetchall()
            crypto_list = []
            for line in db_data:
                crypto_list.append(line[0])
            cursor.close()
            connection.close()
            return crypto_list
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def get_crypto_user(user_id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT crypto_id FROM ref_user_crypto WHERE user_id = ? ", [user_id])
            dbData = cursor.fetchall()
            cryptos_user = []
            for line in dbData:
                cryptos_user.append(line[0])
            cursor.close()
            connection.close()
            return cryptos_user
    except Error as e:
        print(e)


def get_crypto_user_by_id_crypto(crypto_id, user_id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT crypto_name FROM ref_user_crypto WHERE user_id = ? AND  crypto_id = ? ", [user_id, crypto_id])
            dbData = cursor.fetchall()
            cryptos_user = []
            for line in dbData:
                cryptos_user.append(line[0])
            cursor.close()
            connection.close()
            return cryptos_user
    except Error as e:
        print(e)


def get_crypto_anonyme():
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT crypto_id FROM ref_user_crypto WHERE user_id = ?", [1])
            dbData = cursor.fetchall()
            crypto_anonyme = []
            for line in dbData:
                crypto_anonyme.append(line[0])
            cursor.close()
            connection.close()
            return crypto_anonyme
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def add_favori(crypto, user_id):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("INSERT INTO ref_user_crypto(user_id, crypto_id) VALUES(?,?)", [user_id, crypto['crypto_id']]).fetchall()
            connection.commit()
            cursor.close()
            connection.close()
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def add_crypto(crypto):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("INSERT INTO crypto(crypto_name, symbole, crypto_id) VALUES(?,?,?)",
                           [crypto['crypto_name'], crypto['symbole'], crypto['crypto_id']]).fetchall()
            connection.commit()
            cursor.close()
            connection.close()
            return crypto
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def update_crypto(crypto):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("UPDATE crypto SET crypto_name = ?, symbole = ?, crypto_id = ? WHERE id = ?",
                           (crypto['crypto_name'], crypto['symbole'], crypto['crypto_id'], crypto['id'])).fetchall()
            connection.commit()
            cursor.close()
            connection.close()
            return crypto
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def delete_crypto_user(crypto, user):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("DELETE FROM ref_user_crypto WHERE crypto_id = ? AND user_id = ?", [crypto['crypto_id'], user['id']])
            connection.commit()
            cursor.close()
            connection.close()
            return crypto
        else:
            raise DbFailedException.DbFailedException()
    except Error as e:
        print(e)


def delete_crypto(crypto):
    try:
        connection = sqlite3.connect(dbFile)
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("DELETE FROM crypto WHERE id = ?", [crypto['id']])
            connection.commit()
            cursor.close()
            connection.close()
            return crypto
        else:
            DbFailedException.DbFailedException
    except Error as e:
        print(e)
