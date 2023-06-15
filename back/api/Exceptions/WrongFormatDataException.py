class WrongFormatDataException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Mauvais format de données"

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
