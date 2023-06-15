import collections
import re
import hashlib

from flask import Flask
from ..repository import userRepository, settingsRepository
from ..Exceptions import UserExistAlreadyException, UserNotFoundException, WrongFormatDataException, WrongRegexPasswordException, UnauthorizedException, WrongPasswordException
from ..utils import generate_token

app = Flask(__name__)

regex_email = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$'
regex_password = '[A-Za-z0-9@#$%^&+=]{8,}'


def user_register(data):
    if type(data) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if data.get("username") is None or data.get('email') is None or data.get('password') is None or data.get('oauth') is None or data.get('profil') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['username']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['email']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['password']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['oauth']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['profil']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if re.search(regex_email, data['email']):
        if re.fullmatch(regex_password, data['password']):
            ciphered_password = hashlib.md5(data['password'].encode())
            ciphered_password = str(ciphered_password.hexdigest())
            user = {
                'username': data['username'],
                'email': data['email'],
                'password': ciphered_password,
                'oauth': data['oauth'],
                'profil': data['profil']
            }
            users = get_user_by_email(data)
            if users:
                raise UserExistAlreadyException.UserExistAlreadyException()
            else:
                userRepository.add_user(user)
                user_add = userRepository.find_user_email(user['email'])
                admin = collections.OrderedDict()
                admin['id'] = 1
                settings_admin = settingsRepository.get_by_user_id(admin)
                for line in settings_admin:
                    settingsRepository.add_setting_user(line, user_add['id'])
                return user
        else:
            raise WrongRegexPasswordException.WrongRegexPasswordException()
    else:
        raise WrongFormatDataException.WrongFormatDataException()


def user_login(data):
    if type(data) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if data.get('email') is None or data.get('password') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['email']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(data['password']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if re.search(regex_email, data['email']):
        token = None
        user = None
        user = get_user_by_email(data)
        if len(user) != 0:
            settings_user = settingsRepository.get_by_user_id(user)
            user_connected = []
            ciphered_password = hashlib.md5(data['password'].encode())
            ciphered_password = str(ciphered_password.hexdigest())
            if data['email'] == user['email'] and ciphered_password == user['password']:
                token = generate_token.generate_token(user, "200", "True")
                user_connected.append(token)
                user_connected.append(user)
                user_connected.append(settings_user)
            else:
                token = {
                    "success": "False",
                    "message": "Credentials incorrect"
                }
                user_connected.append(token)
            return user_connected
        else:
            raise UserNotFoundException.UserNotFoundException()
    else:
        raise WrongFormatDataException.WrongFormatDataException()


def get_user_by_email(user):
    if type(user) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if user.get('email') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(user['email']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if re.search(regex_email, user['email']):
        user_find = userRepository.find_user_email(user['email'])
        return user_find
    else:
        raise WrongFormatDataException.WrongFormatDataException()


def get_user_by_id(user):
    if type(user) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if user.get('id') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    user_find = userRepository.find_user_id(user['id'])
    return user_find


def update_user(new_user, user):
    if type(new_user) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if new_user.get('username') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if new_user.get('email') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(new_user['username']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(new_user['email']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    find_user = get_user_by_id(user)
    if find_user:
        user_updated = userRepository.update_user(new_user, user)
        return user_updated
    else:
        raise UserNotFoundException.UserNotFoundException()


def update_password(passwords, user):
    ciphered_password = hashlib.md5(passwords['old_password'].encode())
    ciphered_password = str(ciphered_password.hexdigest())
    if ciphered_password == user['password']:
        if re.fullmatch(regex_password, passwords['new_password']):
            userRepository.update_password(str((hashlib.md5(passwords['new_password'].encode())).hexdigest()), user['id'])
        else:
            raise WrongRegexPasswordException.WrongRegexPasswordException()
    else:
        raise WrongPasswordException.WrongPasswordException()


def delete_user(user, user_connected):
    if user_connected['profil'] != "ADMIN":
        raise UnauthorizedException.UnauthorizedException()
    if type(user) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if user.get('id') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    find_user = get_user_by_id(user)
    if find_user:
        user_deleted = userRepository.delete_user(user['id'])
        return user_deleted
    else:
        raise UserNotFoundException.UserNotFoundException()
