from flask import Flask
from ..repository import settingsRepository
from ..Exceptions import SettingDoesntWorkException, SettingExistAlreadyException, SettingNotExistException, WrongFormatDataException, UnauthorizedException

app = Flask(__name__)


def get_all_settings(user_connected):
    if user_connected['profil'] != "ADMIN":
        raise UnauthorizedException.UnauthorizedException()
    settings_list = settingsRepository.get_all()
    if settings_list is not None:
        return settings_list
    else:
        raise SettingDoesntWorkException.SettingDoesntWorkException()


def get_by_user_id(user):
    settings_list = settingsRepository.get_by_user_id(user)
    if settings_list is not None:
        return settings_list
    else:
        raise SettingDoesntWorkException.SettingDoesntWorkException()


def get_setting_anonyme():
    settings_list = settingsRepository.get_setting_anonyme()
    if len(settings_list) != 0:
        return settings_list
    else:
        raise SettingDoesntWorkException.SettingDoesntWorkException()


def add_setting_user(setting, user):
    if type(setting) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if setting.get('setting_name') is None or setting.get('status') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    settings_user = settingsRepository.get_by_user_id_setting_name(user, setting['setting_name'])
    if len(settings_user) != 0:
        raise SettingExistAlreadyException.SettingExistAlreadyException()
    else:
        settings_list = settingsRepository.add_setting_user(setting, user['id'])
        if settings_list is not None:
            return settings_list
        else:
            raise SettingDoesntWorkException.SettingDoesntWorkException()


def update_setting(setting, user):
    if type(setting) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if setting.get('setting_name') is None or setting.get('status') is None or setting.get('id') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    settings_user = settingsRepository.get_by_user_id(user)
    if settings_user is None:
        raise SettingNotExistException.SettingNotExistException()
    else:
        settings_list = settingsRepository.update_setting(setting, user)
        if settings_list is not None:
            return settings_list
        else:
            raise SettingDoesntWorkException.SettingDoesntWorkException()


def delete_setting(setting, user):
    if type(setting) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    settings_user = settingsRepository.get_by_user_id(user)
    if settings_user is None:
        raise SettingNotExistException.SettingNotExistException()
    else:
        settings_list = settingsRepository.delete_setting(setting, user)
        if settings_list is not None:
            return settings_list
        else:
            raise SettingDoesntWorkException.SettingDoesntWorkException()
