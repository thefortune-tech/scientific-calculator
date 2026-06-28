import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scientific_calculator/domain/repositories/calculator_repository.dart';
import 'package:scientific_calculator/domain/usecases/evaluate_expression.dart';

class MockCalculatorRepository extends Mock implements CalculatorRepository {}

void main() {
  late EvaluateExpression usecase;
  late MockCalculatorRepository mockRepository;

  setUp(() {
    mockRepository = MockCalculatorRepository();
    usecase = EvaluateExpression(mockRepository);
  });

  test('should return result from repository', () async {
    when(() => mockRepository.evaluate('2+3')).thenAnswer((_) async => '5');

    final result = await usecase(EvaluateParams(expression: '2+3'));

    expect(result, '5');
    verify(() => mockRepository.evaluate('2+3')).called(1);
  });

  test('should return error for invalid expression', () async {
    when(() => mockRepository.evaluate('abc')).thenAnswer((_) async => 'Error');

    final result = await usecase(EvaluateParams(expression: 'abc'));

    expect(result, 'Error');
  });
}