from flask import Flask
from api.blueprints import user, crypto, setting


app = Flask(__name__)


class Server:
    def __init__(self):
        app.register_blueprint(user.userBp)
        app.register_blueprint(crypto.cryptoBp)
        app.register_blueprint(setting.settingBp)

    def run(self):
        app.run("127.0.0.1")


server = Server()
server.run()
