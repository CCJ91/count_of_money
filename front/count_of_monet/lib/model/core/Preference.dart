import 'package:hive_flutter/hive_flutter.dart';

part 'Preference.g.dart';

@HiveType(typeId: 0)
class Preference {
  @HiveField(0)
  bool themeMode;

  @HiveField(1)
  String prefSelectedLanguageCode;

  @HiveField(2)
  int themeModeId;

  @HiveField(3)
  int languageCodeId;

  Preference({
    required this.themeMode,
    required this.prefSelectedLanguageCode,
    required this.themeModeId,
    required this.languageCodeId,
  });

  factory Preference.empty() {
    return Preference(
      themeMode: false,
      prefSelectedLanguageCode: "",
      themeModeId: 0,
      languageCodeId: 0,
    );
  }
}
