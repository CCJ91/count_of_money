import json
from flask import Flask, Blueprint, request
from ..utils import validate_token
from ..services import settingService
from ..Exceptions import SettingNotExistException, SettingExistAlreadyException, SettingDoesntWorkException, DbFailedException, WrongFormatDataException, UnauthorizedException

app = Flask(__name__)

settingBp = Blueprint('setting', __name__)

setting_not_exist = {"message": "Ce setting n'existe pas.", "status": 500}
setting_exist = {"message": "Ce setting existe déjà.", "status": 500}
setting_not_work = {"message": "Le traitement du setting est impossible.", "status": 500}
db_failed = {"message": "La DB a recontré un problème.", "status": 500}
wrong_data = {"message": "Mauvais format de données", "status": 500}
unauthorized = {"message": "Vous n'avez pas les droits", "status": 401}


# Route permettant d'obtenir une liste de tout les settings en DB
@settingBp.route("/setting", methods=['GET'])
@validate_token.token_required
def get_all(user):
    try:
        settings_list = settingService.get_all_settings(user)
        return {
            "message": "settings find",
            "status": 200,
            "body": settings_list
        }
    except SettingDoesntWorkException.SettingDoesntWorkException:
        return setting_not_work
    except DbFailedException.DbFailedException:
        return db_failed
    except UnauthorizedException.UnauthorizedException:
        return unauthorized


# Route permettant d'obtenir une liste de tout les settings
# pour l'utilisateur connecté
@settingBp.route("/setting/user", methods=['GET'])
@validate_token.token_required
def get_by_user_id(user):
    try:
        settings_list = settingService.get_by_user_id(user)
        return {
            "message": "settings find",
            "status": 200,
            "body": settings_list
        }
    except SettingDoesntWorkException.SettingDoesntWorkException:
        return setting_not_work
    except DbFailedException.DbFailedException:
        return db_failed


@settingBp.route("/setting/anonyme", methods=['GET'])
def get_setting_anonyme():
    try:
        settings_list = settingService.get_setting_anonyme()
        return {
            "message": "settings find",
            "status": 200,
            "body": settings_list
        }
    except DbFailedException.DbFailedException:
        return db_failed
    except SettingDoesntWorkException.SettingDoesntWorkException:
        return setting_not_work


# Route permettant d'ajouter un setting pour l'utilisateur connecté
@settingBp.route("/setting/user", methods=['POST'])
@validate_token.token_required
def add_setting(user):
    try:
        setting = settingService.add_setting_user(json.loads(request.data), user)
        return {
            "message": "setting ajouté",
            "status": 200,
            "body": setting
        }
    except SettingExistAlreadyException.SettingExistAlreadyException:
        return setting_exist
    except SettingDoesntWorkException.SettingDoesntWorkException:
        return setting_not_work
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


# Route permettant d'update un setting pour l'utilisateur connecté
@settingBp.route("/setting/user", methods=['PUT'])
@validate_token.token_required
def update_setting(user):
    try:
        setting = settingService.update_setting(json.loads(request.data), user)
        return {
            "message": "setting update",
            "status": 200,
            "body": setting
        }
    except SettingDoesntWorkException.SettingDoesntWorkException:
        return setting_not_work
    except SettingNotExistException.SettingNotExistException:
        return setting_not_exist
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


# Route permettant de supprimer un setting pour l'utilisateur connecté
@settingBp.route("/setting/user", methods=['DELETE'])
@validate_token.token_required
def delete_setting(user):
    try:
        setting = settingService.delete_setting(json.loads(request.data), user)
        return {
            "message": "setting delete",
            "status": 200,
            "body": setting
        }
    except SettingDoesntWorkException.SettingDoesntWorkException:
        return setting_not_work
    except SettingNotExistException.SettingNotExistException:
        return setting_not_exist
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data
