// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Preference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferenceAdapter extends TypeAdapter<Preference> {
  @override
  final int typeId = 0;

  @override
  Preference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preference(
      themeMode: fields[0] as bool,
      prefSelectedLanguageCode: fields[1] as String,
      themeModeId: fields[2] as int,
      languageCodeId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Preference obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.themeMode)
      ..writeByte(1)
      ..write(obj.prefSelectedLanguageCode)
      ..writeByte(2)
      ..write(obj.themeModeId)
      ..writeByte(3)
      ..write(obj.languageCodeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
