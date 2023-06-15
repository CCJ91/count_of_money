import jwt, json
from flask import Flask, request, jsonify
from functools import wraps
from ..services import userService

app = Flask(__name__)
app.config.from_pyfile("../../config.py")


def token_required(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        token = None
        if'x-access-tokens' in request.headers:
            token = request.headers['x-access-tokens']
        if not token:
            return jsonify({'message': 'valid token is missing'})

        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms='HS256')
            user = userService.get_user_by_id(data)
            current_user = {
                'id': user['id'],
                'username': user['username'],
                'email': user['email'],
                'profil': user['profil'],
                'oauth': user['oauth'],
                'password': user['password']
            }
            return f(current_user, **kwargs)
        except Exception as e:
            print(e)
            print(jwt.decode(token, app.config['SECRET_KEY'], algorithms='HS256'))
            return jsonify({'message': 'token is invalid', 'status': 500})
    return decorator
