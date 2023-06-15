import json
from flask import Flask, Blueprint, request
from ..utils import validate_token
from ..services import cryptoService
from ..Exceptions import DbFailedException, CryptoFavoriExistAlreadyException, CryptoDbDoesntWorkException, CryptoNotExistException, WrongFormatDataException, UnauthorizedException

app = Flask(__name__)

cryptoBp = Blueprint('crypto', __name__)

no_crypto = {"message": "Impossible de traiter la crypto", "status": 500}
db_failed = {"message": "Une erreur est survenue sur la DB", "status": 500}
crypto_not_exist = {"message": "Impossible de trouver la crypto", "status": 500}
wrong_data = {"message": "Mauvaise format de données", "status": 500}
unauthorized = {"message": "Vous n'avez pas les droits", "status": 401}


# Route qui retourne une liste de toutes les cryptos en DB,
# avec la spécification "favori" pour l'utilisateur connecté
@cryptoBp.route("/crypto/user", methods=['GET'])
@validate_token.token_required
def crypto_by_user_id(user):
    crypto_list = cryptoService.get_cryptolist_for_user(user)
    return {
        "message": "cryptos find",
        "status": 200,
        "body": crypto_list
    }


# Route permettant d'obtenir les cryptos à afficher pour utilisateur anonyme
@cryptoBp.route("/crypto/anonyme", methods=['GET'])
def crypto_for_anonyme():
    crypto_list = cryptoService.get_crypto_anonyme()
    return {
        "message": "cryptos find",
        "status": 200,
        "body": crypto_list
    }


# Route permettant d'ajouter une crypto "favorite" dans la table ref_user_crypto
# pour l'utilisateur connecté
@cryptoBp.route("/crypto/user", methods=['POST'])
@validate_token.token_required
def add_crypto_favori(user):
    try:
        crypto_favori = cryptoService.add_cryto_favori(json.loads(request.data), user)
        return {
            "message": "crypto favori save",
            "status": 200,
            "body": crypto_favori
        }
    except DbFailedException.DbFailedException:
        return db_failed
    except CryptoFavoriExistAlreadyException.CryptoFavoriExistAlreadyException:
        return no_crypto
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


# Route permettant d'ajouter une crypto dans la table crypto
@cryptoBp.route("/crypto", methods=['POST'])
@validate_token.token_required
def add_crypto(user):
    try:
        cryptoService.add_crypto(json.loads(request.data), user)
        return {
            "message": "crypto add",
            "status": 200
        }
    except CryptoDbDoesntWorkException.CryptoDbDoesntWorkException:
        return no_crypto
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data
    except UnauthorizedException.UnauthorizedException:
        unauthorized


# Route permettant d'update une crypto dans la table crypto
@cryptoBp.route("/crypto", methods=['PUT'])
@validate_token.token_required
def update_crypto(user):
    try:
        crypto_update = cryptoService.update_crypto(json.loads(request.data), user)
        return {
            "message": "crypto update",
            "status": 200,
            "body": crypto_update
        }
    except CryptoDbDoesntWorkException.CryptoDbDoesntWorkException:
        return no_crypto
    except DbFailedException.DbFailedException:
        return db_failed
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data
    except UnauthorizedException.UnauthorizedException:
        unauthorized


# Route permettant de supprimer une crypto "favori" dans la table ref_user_crypto,
# pour l'utilisateur connecté
@cryptoBp.route("/crypto/user", methods=['DELETE'])
@validate_token.token_required
def delete_crypto_user(user):
    try:
        crypto_delete = cryptoService.delete_crypto_user(json.loads(request.data), user)
        return {
            "message": "crypto favori delete",
            "status": 200,
            "body": crypto_delete
        }
    except DbFailedException.DbFailedException:
        return db_failed
    except CryptoDbDoesntWorkException.CryptoDbDoesntWorkException:
        return no_crypto
    except CryptoNotExistException.CryptoNotExistException:
        return crypto_not_exist
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data


# Route permettant de supprimer une crypto dans la table crypto
@cryptoBp.route("/crypto", methods=['DELETE'])
@validate_token.token_required
def delete_crypto(user):
    try:
        crypto_delete = cryptoService.delete_crypto(json.loads(request.data), user)
        return {
            "message": "crypto delete",
            "status": 200
        }
    except DbFailedException.DbFailedException:
        return db_failed
    except CryptoDbDoesntWorkException.CryptoDbDoesntWorkException:
        return no_crypto
    except CryptoNotExistException.CryptoNotExistException:
        return crypto_not_exist
    except WrongFormatDataException.WrongFormatDataException:
        return wrong_data
    except UnauthorizedException.UnauthorizedException:
        return unauthorized
