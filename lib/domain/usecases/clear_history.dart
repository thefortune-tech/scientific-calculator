import '../repositories/calculator_repository.dart';
import '../../core/usecases/usecase.dart';

class ClearHistory extends UseCase<void, NoParams> {
  final CalculatorRepository repository;

  ClearHistory(this.repository);

  @override
  Future<void> call(NoParams params) async {
    await repository.clearHistory();
  }
}