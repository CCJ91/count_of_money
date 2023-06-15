class WrongPasswordException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Mauvais mot de passe"

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
