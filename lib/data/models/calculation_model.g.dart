// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculationModelAdapter extends TypeAdapter<CalculationModel> {
  @override
  final int typeId = 0;

  @override
  CalculationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculationModel(
      id: fields[0] as String,
      expression: fields[1] as String,
      result: fields[2] as String,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CalculationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.expression)
      ..writeByte(2)
      ..write(obj.result)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
