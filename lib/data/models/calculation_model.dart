import 'package:hive/hive.dart';
import '../../domain/entities/calculation.dart';

part 'calculation_model.g.dart';

@HiveType(typeId: 0)
class CalculationModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String expression;

  @HiveField(2)
  final String result;

  @HiveField(3)
  final DateTime timestamp;

  CalculationModel({
    required this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  factory CalculationModel.fromEntity(Calculation calculation) {
    return CalculationModel(
      id: calculation.id,
      expression: calculation.expression,
      result: calculation.result,
      timestamp: calculation.timestamp,
    );
  }

  Calculation toEntity() {
    return Calculation(
      id: id,
      expression: expression,
      result: result,
      timestamp: timestamp,
    );
  }
}