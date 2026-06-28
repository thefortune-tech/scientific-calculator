import '../repositories/calculator_repository.dart';
import '../../core/usecases/usecase.dart';

class EvaluateExpression extends UseCase<String, EvaluateParams> {
  final CalculatorRepository repository;

  EvaluateExpression(this.repository);

  @override
  Future<String> call(EvaluateParams params) async {
    return await repository.evaluate(params.expression);
  }
}

class EvaluateParams {
  final String expression;

  EvaluateParams({required this.expression});
}