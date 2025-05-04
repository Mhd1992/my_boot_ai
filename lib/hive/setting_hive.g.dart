// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsHiveAdapter extends TypeAdapter<SettingsHive> {
  @override
  final int typeId = 2;

  @override
  SettingsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsHive(
      isDarkTheme: fields[0] as bool,
      shouldSpeak: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isDarkTheme)
      ..writeByte(1)
      ..write(obj.shouldSpeak);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
