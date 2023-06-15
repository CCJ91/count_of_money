class CryptoFavoriExistAlreadyException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Erreur sur crypto user."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
