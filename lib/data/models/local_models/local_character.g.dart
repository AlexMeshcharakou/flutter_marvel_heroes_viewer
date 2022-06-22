// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalCharacterAdapter extends TypeAdapter<LocalCharacter> {
  @override
  final int typeId = 0;

  @override
  LocalCharacter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalCharacter(
      smallThumbnailUrl: fields[4] as String?,
      bigThumbnailUrl: fields[5] as String?,
      id: fields[0] as int,
      name: fields[1] as String,
      title: fields[2] as String?,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalCharacter obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.smallThumbnailUrl)
      ..writeByte(5)
      ..write(obj.bigThumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalCharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
