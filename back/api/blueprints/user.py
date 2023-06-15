import json

from flask import Flask, Blueprint, request
from ..services import userService
from ..Exceptions import UserExistAlreadyException, UserNotFoundException, DbFailedException, WrongFormatDataException, WrongRegexPasswordException, UnauthorizedException, WrongPasswordException
from ..utils import validate_token

app = Flask(__name__)

userBp = Blueprint('user', __name__)

no_user_created = {"message":"Impossible de créer l'utilisateur", "status": 500}
no_user_find = {"message": "Impossible de trouver l'utilisateur", "status": 500}
db_failed = {"message": "Impossible d'ouvrir la db", "status": 500}
wrong_data = {"message": "Mauvaise format de données", "status": 500}
wrong_mdp = {"message": "La regex du mdp n'est pas respectée", "status": 500}
unauthorized = {"message": "Vous n'avez pas les droits", "status": 401}
wrong_password = {"message": "Le mot de passe est incorrect", "status": 500}


# Route permettant d'obtenir un utilisateur par son ID
@userBp.route("/user", methods=['POST'])
@validate_token.token_required
def user(user):
    try:
        user = userService.get_user_by_id(json.loads(request.data))
        return {
            "message": "user find",
            "body": user,
            "status": 200
        }
    except UserNotFoundException.UserNotFoundException:
        return {
            "message": "no user find",
            "status": 500
        }


# Route permettant d'enregistrer un utilisateur
@userBp.route("/user/register", methods=['POST'])
def user_register():
    try:
        user = userService.user_register(json.loads(request.data))
        return {
            "message": "user save",
            "body": user,
            "status": 200
        }
    except UserExistAlreadyException.UserExistAlreadyException:
        return no_user_created
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data
    except WrongRegexPasswordException.WrongRegexPasswordException:
        return wrong_mdp


# Route permettant de se connecter
@userBp.route("/user/login", methods=['POST'])
def login():
    try:
        user = userService.user_login(json.loads(request.data))
        return {
            "message": "user connected",
            "body": user,
            "status": 200
        }
    except UserNotFoundException.UserNotFoundException:
        return no_user_find
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


# Route permettant d'obtenir un utilisateur par son email
@userBp.route("/user/email", methods=['POST'])
def user_email():
    try:
        user_find = userService.get_user_by_email(json.loads(request.data))
        return {
            "message": "user find",
            "status": 200,
            "body": user_find
        }
    except UserNotFoundException.UserNotFoundException:
        return app.make_response(no_user_find)
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


# Route permettant d'update l'utilisateur connecté
@userBp.route("/user", methods=['PUT'])
@validate_token.token_required
def update_user(user):
    try:
        user = userService.update_user(json.loads(request.data), user)
        return {
            "message": "user updated",
            "body": user,
            "status": 200
        }
    except UserNotFoundException.UserNotFoundException:
        return no_user_find
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


@userBp.route("/user/password", methods=['PUT'])
@validate_token.token_required
def update_password_user(user):
    try:
        userService.update_password(json.loads(request.data), user)
        return {
            "message": "password updated",
            "status": 200
        }
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongPasswordException.WrongPasswordException:
        return wrong_password
    except WrongRegexPasswordException.WrongRegexPasswordException:
        return wrong_mdp


# Route permettant de supprimer un utilisateur
@userBp.route("/user", methods=['DELETE'])
@validate_token.token_required
def delete_user(user):
    try:
        user = userService.delete_user(json.loads(request.data), user)
        return {
            "message": "user deleted",
            "body": user,
            "status": 200
        }
    except UserNotFoundException.UserNotFoundException:
        return no_user_find
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data
    except UnauthorizedException.UnauthorizedException:
        return unauthorized

