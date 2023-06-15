class WrongRegexPasswordException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "La regex du mdp n'est pas respectée"

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
