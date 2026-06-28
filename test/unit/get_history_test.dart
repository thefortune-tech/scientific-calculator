import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scientific_calculator/core/usecases/usecase.dart';
import 'package:scientific_calculator/domain/entities/calculation.dart';
import 'package:scientific_calculator/domain/repositories/calculator_repository.dart';
import 'package:scientific_calculator/domain/usecases/get_history.dart';

class MockCalculatorRepository extends Mock implements CalculatorRepository {}

void main() {
  late GetHistory usecase;
  late MockCalculatorRepository mockRepository;

  setUp(() {
    mockRepository = MockCalculatorRepository();
    usecase = GetHistory(mockRepository);
  });

  test('should return list of calculations from repository', () async {
    final calculations = [
      Calculation(
        id: '1',
        expression: '2+3',
        result: '5',
        timestamp: DateTime.now(),
      ),
      Calculation(
        id: '2',
        expression: '10÷2',
        result: '5',
        timestamp: DateTime.now(),
      ),
    ];

    when(() => mockRepository.getHistory())
        .thenAnswer((_) async => calculations);

    final result = await usecase(NoParams());

    expect(result.length, 2);
    expect(result.first.expression, '2+3');
    verify(() => mockRepository.getHistory()).called(1);
  });

  test('should return empty list when no history', () async {
    when(() => mockRepository.getHistory()).thenAnswer((_) async => []);

    final result = await usecase(NoParams());

    expect(result, isEmpty);
  });
}