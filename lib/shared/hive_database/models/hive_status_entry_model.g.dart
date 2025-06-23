// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_status_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveStatusEntryModelAdapter extends TypeAdapter<HiveStatusEntryModel> {
  @override
  final int typeId = 2;

  @override
  HiveStatusEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveStatusEntryModel(
      userStatus: fields[0] as UserStatus,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveStatusEntryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userStatus)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveStatusEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
