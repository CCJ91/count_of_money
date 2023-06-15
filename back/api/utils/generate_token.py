import jwt

from flask import Flask

app = Flask(__name__)
app.config.from_pyfile("../../config.py")


def generate_token(user, message, success):
    token = {
        "success": success,
        "token": jwt.encode({
            'id': str(user['id']),
            'username': str(user['username']),
            'email': str(user['email']),
            'oauth': str(user['oauth']),
            'profil': str(user['profil'])
        },
        app.config['SECRET_KEY'], algorithm='HS256'),
        "message": message
    }
    return token
