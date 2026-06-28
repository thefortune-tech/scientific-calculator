import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scientific_calculator/core/usecases/usecase.dart';
import 'package:scientific_calculator/domain/repositories/calculator_repository.dart';
import 'package:scientific_calculator/domain/usecases/clear_history.dart';

class MockCalculatorRepository extends Mock implements CalculatorRepository {}

void main() {
  late ClearHistory usecase;
  late MockCalculatorRepository mockRepository;

  setUp(() {
    mockRepository = MockCalculatorRepository();
    usecase = ClearHistory(mockRepository);
  });

  test('should call clearHistory on repository', () async {
    when(() => mockRepository.clearHistory()).thenAnswer((_) async {});

    await usecase(NoParams());

    verify(() => mockRepository.clearHistory()).called(1);
  });
}