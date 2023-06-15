import os
from os import path
from dotenv import load_dotenv

basedir = path.abspath(path.dirname(__file__))
load_dotenv(path.join(basedir, '.env'))
key = str(os.urandom(24))

if os.path.exists(".env"):
    os.remove(".env")

with open('.env', 'w') as envFile:
    envFile.write("SECRET_KEY="+key)

SECRET_KEY = os.environ.get('SECRET_KEY')
DB_FILE = r"countOfMonet.db"
