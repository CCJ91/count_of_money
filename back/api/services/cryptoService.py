
from flask import Flask
from ..repository import cryptoRepository
from ..Exceptions import CryptoFavoriExistAlreadyException, CryptoDbDoesntWorkException, CryptoNotExistException, WrongFormatDataException, UnauthorizedException

app = Flask(__name__)


def get_cryptolist_for_user(user):
    crypto_list = cryptoRepository.get_all()
    if len(crypto_list) != 0:
        cryptos_user = cryptoRepository.get_crypto_user(user['id'])
        for crypto in crypto_list:
            try:
                index = cryptos_user.index(crypto['crypto_id'])
                if index is not None:
                    crypto['favori'] = True
            except ValueError:
                crypto['favori'] = False
        return crypto_list


def get_crypto_anonyme():
    crypto_list = cryptoRepository.get_crypto_anonyme()
    return crypto_list


def add_cryto_favori(crypto, user):
    if type(crypto) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if crypto.get('crypto_id') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['crypto_id']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    cryptos_user = cryptoRepository.get_crypto_user_by_id_crypto(crypto['crypto_id'], user['id'])
    if cryptos_user is not None:
        raise CryptoFavoriExistAlreadyException.CryptoFavoriExistAlreadyException()
    else:
        cryptoRepository.add_favori(crypto, user['id'])
        return crypto


def add_crypto(crypto, user_connected):
    if user_connected['profil'] != "ADMIN":
        raise UnauthorizedException.UnauthorizedException()
    if type(crypto) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if crypto.get('crypto_id') is None or crypto.get('crypto_name') is None or crypto.get('symbole') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['crypto_id']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['crypto_name']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['symbole']) is not str:
        WrongFormatDataException.WrongFormatDataException()
    crypto_add = cryptoRepository.add_crypto(crypto)
    if crypto_add is not None:
        return crypto_add
    else:
        raise CryptoDbDoesntWorkException.CryptoDbDoesntWorkException()


def update_crypto(crypto, user_connected):
    if user_connected['profil'] != "ADMIN":
        raise UnauthorizedException.UnauthorizedException()
    if type(crypto) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if crypto.get('id') is None or crypto.get('crypto_id') is None or crypto.get('crypto_name') is None or crypto.get('symbole') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['crypto_id']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['crypto_name']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['symbole']) is not str:
        WrongFormatDataException.WrongFormatDataException()
    crypto_update = cryptoRepository.update_crypto(crypto)
    if crypto_update is not None:
        return crypto_update
    else:
        raise CryptoDbDoesntWorkException.CryptoDbDoesntWorkException()


def delete_crypto_user(crypto, user):
    if type(crypto) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if crypto.get('crypto_id') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    if type(crypto['crypto_id']) is not str:
        raise WrongFormatDataException.WrongFormatDataException()
    crypto_user = cryptoRepository.get_crypto_user(user['id'])
    try:
        index = crypto_user.index(crypto['crypto_id'])
        if index is not None:
            crypto_delete = cryptoRepository.delete_crypto_user(crypto, user)
            if crypto_delete is not None:
                return crypto
            else:
                raise CryptoDbDoesntWorkException.CryptoDbDoesntWorkException()
    except ValueError:
        raise CryptoNotExistException.CryptoNotExistException()


def delete_crypto(crypto, user_connected):
    if user_connected['profil'] != "ADMIN":
        raise UnauthorizedException.UnauthorizedException()
    if type(crypto) is not dict:
        raise WrongFormatDataException.WrongFormatDataException()
    if crypto.get('id') is None:
        raise WrongFormatDataException.WrongFormatDataException()
    crypto_find = cryptoRepository.get_crypto(crypto)
    if crypto_find is not None:
        crypto_delete = cryptoRepository.delete_crypto(crypto)
        if crypto_delete is not None:
            return crypto_delete
        else:
            raise CryptoDbDoesntWorkException.CryptoDbDoesntWorkException()
    else:
        raise CryptoNotExistException.CryptoNotExistException()