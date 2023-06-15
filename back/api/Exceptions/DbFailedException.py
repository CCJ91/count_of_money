class DbFailedException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Connection à la db impossible."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage