class SettingDoesntWorkException(BaseException):
    errorMessage = ""

    def __init__(self):
        BaseException.__init__(self)
        self.errorMessage = "Erreur sur la table setting."

    def return_exception(self):
        print(self.errorMessage)
        return self.errorMessage
