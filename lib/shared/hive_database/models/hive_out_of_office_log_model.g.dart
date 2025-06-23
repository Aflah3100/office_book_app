// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_out_of_office_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOutOfOfficeLogModelAdapter
    extends TypeAdapter<HiveOutOfOfficeLogModel> {
  @override
  final int typeId = 5;

  @override
  HiveOutOfOfficeLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOutOfOfficeLogModel(
      userId: fields[0] as String,
      startDate: fields[1] as DateTime,
      endDate: fields[2] as DateTime,
      month: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOutOfOfficeLogModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.month);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutOfOfficeLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
