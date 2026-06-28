import '../entities/calculation.dart';
import '../repositories/calculator_repository.dart';
import '../../core/usecases/usecase.dart';

class SaveCalculation extends UseCase<void, SaveCalculationParams> {
  final CalculatorRepository repository;

  SaveCalculation(this.repository);

  @override
  Future<void> call(SaveCalculationParams params) async {
    await repository.saveCalculation(params.calculation);
  }
}

class SaveCalculationParams {
  final Calculation calculation;

  SaveCalculationParams({required this.calculation});
}