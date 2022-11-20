// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedDataAdapter extends TypeAdapter<CachedData> {
  @override
  final int typeId = 169;

  @override
  CachedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedData(
      fields[0] as String,
      fields[1] as Uint8List,
      fields[2] as DateTime,
      fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.storageRefFullPath)
      ..writeByte(1)
      ..write(obj.bytes)
      ..writeByte(2)
      ..write(obj.cacheCreated)
      ..writeByte(3)
      ..write(obj.cacheExpires);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
