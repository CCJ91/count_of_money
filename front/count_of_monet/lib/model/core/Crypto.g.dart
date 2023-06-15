// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Crypto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoAdapter extends TypeAdapter<Crypto> {
  @override
  final int typeId = 1;

  @override
  Crypto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Crypto(
      cryptoId: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[2] as String,
      linkImage: fields[3] as String,
      genesisDate: fields[4] as String,
      twitterName: fields[5] as String,
      facebookName: fields[6] as String,
      redditLink: fields[7] as String,
      currentPrice: fields[8] as double,
      ath: fields[9] as double,
      athChangePer: fields[10] as double,
      markerCap: fields[11] as int,
      volume: fields[12] as int,
      high24: fields[13] as double,
      low24: fields[14] as double,
      priceChange24h: fields[15] as double,
      isFav: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Crypto obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.cryptoId)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.linkImage)
      ..writeByte(4)
      ..write(obj.genesisDate)
      ..writeByte(5)
      ..write(obj.twitterName)
      ..writeByte(6)
      ..write(obj.facebookName)
      ..writeByte(7)
      ..write(obj.redditLink)
      ..writeByte(8)
      ..write(obj.currentPrice)
      ..writeByte(9)
      ..write(obj.ath)
      ..writeByte(10)
      ..write(obj.athChangePer)
      ..writeByte(11)
      ..write(obj.markerCap)
      ..writeByte(12)
      ..write(obj.volume)
      ..writeByte(13)
      ..write(obj.high24)
      ..writeByte(14)
      ..write(obj.low24)
      ..writeByte(15)
      ..write(obj.priceChange24h)
      ..writeByte(16)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
