class CryptoNotExistException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Cette crypto n'existe pas."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
