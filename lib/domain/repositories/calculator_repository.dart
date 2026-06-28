import '../entities/calculation.dart';

abstract class CalculatorRepository {
  Future<String> evaluate(String expression);
  Future<void> saveCalculation(Calculation calculation);
  Future<List<Calculation>> getHistory();
  Future<void> clearHistory();
  Future<void> deleteCalculation(String id);
  void setDegreeMode(bool isDegree);
}