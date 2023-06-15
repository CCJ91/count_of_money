class UnauthorizedException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Vous n'avez pas les droits."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
