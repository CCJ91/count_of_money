class UserNotFoundException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Aucune utilisateur trouvé"

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
