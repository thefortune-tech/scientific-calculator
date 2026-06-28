import '../entities/calculation.dart';
import '../repositories/calculator_repository.dart';
import '../../core/usecases/usecase.dart';

class GetHistory extends UseCase<List<Calculation>, NoParams> {
  final CalculatorRepository repository;

  GetHistory(this.repository);

  @override
  Future<List<Calculation>> call(NoParams params) async {
    return await repository.getHistory();
  }
}