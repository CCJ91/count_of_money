import 'package:count_of_monet/utils/languages/Languages.dart';

class LanguageEs extends Languages {
  //General
  @override
  String get loading => "Chargement";

  @override
  String get selectLanguage => "Selectionner la langue";

  @override
  String get themeSelect => 'Selectionner un thème';
  @override
  String get save => 'Enregistrer';
  @override
  String get settings => 'Paramètres';
  @override
  String get changePassword => 'Changer le mot de passe';
  @override
  String get oldPassword => 'Ancien mot de passe';
  @override
  String get newPassword => 'Nouveau mot de passe';
  @override
  String get confirmPassword => 'Confirmer le mot de passe';
  @override
  String get home => 'Maison';
  @override
  String get press => 'Journal';
  @override
  String get profile => 'Profil';
  @override
  String get enterYourName => "Entrer votre nom";
  @override
  String get emailInvalid => "Email invalide";

  @override
  String get validationName => 'Entrez votre nom';
  @override
  String get validationEmail => 'Format d\'email invalide';
  @override
  String get validationOldPassword => 'Ne doit pas être vide';
  @override
  String get validationNewPassword => 'Ne doit pas être vide';
  @override
  String get validationConfirmPassword =>
      'Les mots de passes ne correspondent pas';

  @override
  String get favoritesCrypto => "Cryptos favorite";
  @override
  String get noFavoriteCryptoMessage =>
      'Pensez à ajouter vos crypto-monnaies favorite';
  @override
  String get favoritesPress => "Presses favorite";

  @override
  String get search => "Rechercher";
  @override
  String get filters => "Filtres";
  @override
  String get favorite => "Favoris";

  @override
  String get currentPrice => "Prix actuelle";
  @override
  String get genesisDate => "Date de création";
  @override
  String get ath => "Prix le plus haut";
  @override
  String get perSinceATH => "Pourcentage depuis le prix le plus haut";
  @override
  String get last24Highest => "Plus haut des dernières 24h";
  @override
  String get last24Lowest => "Plus bas des dernières 24h";
  @override
  String get persince24h => "Pourcentage depuis 24h";
  @override
  String get volume => "Volume";
  @override
  String get noDataRssFeed => "Pas de presse disponible";

  //AnoPage
  @override
  String get login => "Connexion";
  @override
  String get logout => "Déconnexion";
  @override
  String get signup => "Inscription";
  @override
  String get email => "Email";
  @override
  String get yourEmail => "Votre email";
  @override
  String get username => "Nom";
  @override
  String get yourUsername => "Votre nom";
  @override
  String get password => "Mot de passe";
  @override
  String get yourPassword => "Votre mot de passe";
  @override
  String get verifyPassword => "Vérifier votre mot de passe";
  @override
  String get passwordDifferent => "Mot de passe différent";
  @override
  String get accountCreated => "Compte créer";
  @override
  String get infoIncorrect => "Email ou mot de passe incorrect";

  @override
  String get errorOccur => "Une erreur est survenue";
}
