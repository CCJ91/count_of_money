import sqlite3
import hashlib
from sqlite3 import Error


def main():
    db_file = '../countOfMonet.db'

    sql_user_table = """CREATE TABLE user(
                            id INTEGER PRIMARY KEY,
                            username VARCHAR(20) NOT NULL,
                            email VARCHAR(20) NOT NULL,
                            password VARCHAR(20) NOT NULL,
                            oauth VARCHAR(200),
                            profil VARCHAR(20)
                        )
                    """

    sql_crypto_table = """CREATE TABLE crypto(
                            id INTEGER PRIMARY KEY,
                            crypto_name VARCHAR(20) NOT NULL,
                            symbole VARCHAR(20) NOT NULL,
                            crypto_id VARCHAR(200) NOT NULL
                            )
                        """

    sql_ref_user_crypto = """CREATE TABLE ref_user_crypto(
                                id INTEGER PRIMARY KEY,
                                user_id INTEGER NOT NULL,
                                crypto_id VARCHAR(200) NOT NULL
                                )
                         """

    sql_press_table = """CREATE TABLE press(
                            id INTEGER PRIMARY KEY,
                            lien TEXT NOT NULL,
                            press_name VARCHAR(20) NOT NULL,
                            display BIT NOT NULL
                            )
                        """

    sql_setting_table = """CREATE TABLE setting(
                            id INTEGER PRIMARY KEY,
                            setting_name VARCHAR(20) NOT NULL,
                            status VARCHAR(20) NOT NULL,
                            setting_user_id INTEGER NOT NULL,
                            FOREIGN KEY (setting_user_id) REFERENCES user(id)
                            )
                        """

    cryptos_to_insert = [
        ("Bitcoin", "btc", "bitcoin"),
        ("Ethereum", "eth", "ethereum"),
        ("Tether", "usdt", "tether"),
        ("BNB", "bnb", "binancecoin"),
        ("USD Coin", "usdc", "usd-coin"),
        ("Binance USD", "busb", "binance-usd"),
        ("XRP", "xrp", "ripple"),
        ("Dogecoin", "doge", "dogecoin"),
        ("Cardano", "ada", "cardano"),
        ("Polygon", "matic", "matic-network"),
        ("Polkadot", "dot", "polkadot"),
        ("Litecoin", "ltc", "litecoin"),
        ("Dai", "dai", "dai"),
        ("Shiba Inu", "shib", "shiba-inu"),
        ("Solana", "sol", "solana"),
        ("TRON", "trx", "tron"),
        ("Uniswap", "uni", "uniswap"),
        ("Avalanche", "avax", "avalanche-2"),
        ("Chainlink", "link", "chainlink"),
        ("Wrapped Bitcoin", "wbtc", "wrapped-bitcoin"),
        ("Cosmos", "atom", "cosmos"),
        ("Ethereum Classic", "etc", "ethereum-classic"),
        ("Monero", "xmr", "monero"),
        ("Toncoin", "ton", "the-open-network"),
        ("Stellar", "xlm", "stellar"),
        ("Bitcoin Cash", "bch", "bitcoin-cash"),
        ("Cronos", "cro", "crypto-com-chain"),
        ("Algorand", "algo", "algorand"),
        ("Filecoin", "fil", "filecoin")
    ]

    connect = create_database(db_file)

    if connect is not None:
        exe_query(connect, "DROP TABLE IF EXISTS user")
        exe_query(connect, "DROP TABLE IF EXISTS crypto")
        exe_query(connect, "DROP TABLE IF EXISTS ref_user_crypto")
        exe_query(connect, "DROP TABLE IF EXISTS press")
        exe_query(connect, "DROP TABLE IF EXISTS setting")

        exe_query(connect, sql_user_table)
        exe_query(connect, sql_crypto_table)
        exe_query(connect, sql_ref_user_crypto)
        exe_query(connect, sql_press_table)
        exe_query(connect, sql_setting_table)

        insert_data(connect, cryptos_to_insert)
        add_admin(connect)


def create_database(db_file):
    connection = None
    try:
        connection = sqlite3.connect(db_file)

    except Error as e:
        print(e)

    return connection


def exe_query(connection, table):
    try:
        c = connection.cursor()
        c.execute(table)
        connection.commit()

    except Error as e:
        print(e)


def insert_data(connection, cryptos):
    cursor = connection.cursor()
    cursor.executemany("INSERT INTO crypto(crypto_name, symbole, crypto_id) VALUES(?,?,?)", cryptos)
    connection.commit()
    cursor.close()


def add_admin(connection):
    ciphered_password = hashlib.md5('admin'.encode())
    ciphered_password = str(ciphered_password.hexdigest())
    cursor = connection.cursor()
    cursor.execute("INSERT INTO user(username, email, password, oauth, profil) VALUES(?,?,?,?,?)", ['admin', 'admin@gmail.com', ciphered_password, 'rien', 'ADMIN'])
    connection.commit()
    cursor.execute("INSERT INTO setting(setting_name, status, setting_user_id) VALUES(?,?,?)", ['language', 'fr', 1])
    connection.commit()
    cursor.execute("INSERT INTO setting(setting_name, status, setting_user_id) VALUES(?,?,?)", ['mode', 'light', 1])
    connection.commit()
    cursor.close()
    connection.close()


if __name__ == '__main__':
    main()

