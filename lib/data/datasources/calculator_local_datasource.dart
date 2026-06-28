import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../models/calculation_model.dart';

abstract class CalculatorLocalDatasource {
  Future<void> saveCalculation(CalculationModel calculation);
  Future<List<CalculationModel>> getHistory();
  Future<void> clearHistory();
  Future<void> deleteCalculation(String id);
}

class CalculatorLocalDatasourceImpl implements CalculatorLocalDatasource {
  final Box<CalculationModel> box;

  CalculatorLocalDatasourceImpl({required this.box});

  @override
  Future<void> saveCalculation(CalculationModel calculation) async {
    await box.put(calculation.id, calculation);
  }

  @override
  Future<List<CalculationModel>> getHistory() async {
    final items = box.values.toList();
    items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    if (items.length > AppConstants.maxHistoryItems) {
      return items.sublist(0, AppConstants.maxHistoryItems);
    }
    return items;
  }

  @override
  Future<void> clearHistory() async {
    await box.clear();
  }

  @override
  Future<void> deleteCalculation(String id) async {
    await box.delete(id);
  }
}