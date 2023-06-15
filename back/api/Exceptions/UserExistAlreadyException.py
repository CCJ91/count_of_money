class UserExistAlreadyException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Cet utilisateur existe déjà."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage