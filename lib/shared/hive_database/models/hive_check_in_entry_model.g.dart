// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_check_in_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCheckInEntryModelAdapter extends TypeAdapter<HiveCheckInEntryModel> {
  @override
  final int typeId = 3;

  @override
  HiveCheckInEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCheckInEntryModel(
      userCheckInEntry: fields[0] as CheckInStatus,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCheckInEntryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userCheckInEntry)
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
      other is HiveCheckInEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
