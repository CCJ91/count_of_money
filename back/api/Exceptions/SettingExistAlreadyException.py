class SettingExistAlreadyException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Ce setting existe déjà."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
