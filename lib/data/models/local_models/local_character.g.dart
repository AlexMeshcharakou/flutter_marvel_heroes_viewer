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
      fields[0] as int,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String,
      fields[4] as LocalThumbnail,
    );
  }

  @override
  void write(BinaryWriter writer, LocalCharacter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.thumbnail);
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

class LocalThumbnailAdapter extends TypeAdapter<LocalThumbnail> {
  @override
  final int typeId = 1;

  @override
  LocalThumbnail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalThumbnail(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalThumbnail obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.extension);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalThumbnailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
