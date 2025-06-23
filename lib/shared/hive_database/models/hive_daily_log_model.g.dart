// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_daily_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDailyLogModelAdapter extends TypeAdapter<HiveDailyLogModel> {
  @override
  final int typeId = 1;

  @override
  HiveDailyLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDailyLogModel(
      userId: fields[0] as String,
      statusLogs: (fields[1] as List).cast<HiveStatusEntryModel>(),
      checkInLogs: (fields[2] as List).cast<HiveCheckInEntryModel>(),
      workDaySummary: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDailyLogModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.statusLogs)
      ..writeByte(2)
      ..write(obj.checkInLogs)
      ..writeByte(3)
      ..write(obj.workDaySummary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDailyLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
