// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_monthly_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMonthlyLogModelAdapter extends TypeAdapter<HiveMonthlyLogModel> {
  @override
  final int typeId = 4;

  @override
  HiveMonthlyLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMonthlyLogModel(
      userId: fields[0] as String,
      month: fields[1] as String,
      totalHoursWorked: fields[2] as String,
      totalHoursSpent: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMonthlyLogModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.totalHoursWorked)
      ..writeByte(3)
      ..write(obj.totalHoursSpent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMonthlyLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
