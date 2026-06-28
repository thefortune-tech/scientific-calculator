import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scientific_calculator/data/datasources/calculator_local_datasource.dart';
import 'package:scientific_calculator/data/models/calculation_model.dart';
import 'package:scientific_calculator/data/repositories/calculator_repository_impl.dart';
import 'package:scientific_calculator/domain/entities/calculation.dart';

class MockCalculatorLocalDatasource extends Mock
    implements CalculatorLocalDatasource {}

void main() {
  late CalculatorRepositoryImpl repository;
  late MockCalculatorLocalDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(CalculationModel(
      id: 'test',
      expression: '1+1',
      result: '2',
      timestamp: DateTime.now(),
    ));
  });

  setUp(() {
    mockDatasource = MockCalculatorLocalDatasource();
    repository = CalculatorRepositoryImpl(localDatasource: mockDatasource);
  });

  group('evaluate', () {
    test('should return correct result for basic addition', () async {
      final result = await repository.evaluate('2+3');
      expect(result, '5');
    });

    test('should return correct result for subtraction', () async {
      final result = await repository.evaluate('10-4');
      expect(result, '6');
    });

    test('should return correct result for multiplication', () async {
      final result = await repository.evaluate('3×4');
      expect(result, '12');
    });

    test('should return correct result for division', () async {
      final result = await repository.evaluate('10÷2');
      expect(result, '5');
    });

    test('should return error for division by zero', () async {
      final result = await repository.evaluate('5÷0');
      expect(result, 'Cannot divide by zero');
    });

    test('should return correct result for sin in degree mode', () async {
      repository.setDegreeMode(true);
      final result = await repository.evaluate('sin(30)');
      expect(double.parse(result), closeTo(0.5, 0.0001));
    });

    test('should return correct result for cos in degree mode', () async {
      repository.setDegreeMode(true);
      final result = await repository.evaluate('cos(60)');
      expect(double.parse(result), closeTo(0.5, 0.0001));
    });

    test('should return correct result for sinh', () async {
      final result = await repository.evaluate('sinh(0)');
      expect(result, '0');
    });

    test('should return correct result for cosh', () async {
      final result = await repository.evaluate('cosh(0)');
      expect(result, '1');
    });

    test('should return correct result for factorial', () async {
      final result = await repository.evaluate('5n!');
      expect(result, '120');
    });

    test('should return correct result for combination', () async {
      final result = await repository.evaluate('C(5,2)');
      expect(result, '10');
    });

    test('should return Error for invalid expression', () async {
      final result = await repository.evaluate('abc');
      expect(result, 'Error');
    });
  });

  group('saveCalculation', () {
    test('should call datasource saveCalculation', () async {
      final calculation = Calculation(
        id: '1',
        expression: '2+3',
        result: '5',
        timestamp: DateTime.now(),
      );

      when(() => mockDatasource.saveCalculation(any()))
          .thenAnswer((_) async {});

      await repository.saveCalculation(calculation);

      verify(() => mockDatasource.saveCalculation(any())).called(1);
    });
  });

  group('getHistory', () {
    test('should return list of calculations', () async {
      final models = [
        CalculationModel(
          id: '1',
          expression: '2+3',
          result: '5',
          timestamp: DateTime.now(),
        ),
      ];

      when(() => mockDatasource.getHistory()).thenAnswer((_) async => models);

      final result = await repository.getHistory();

      expect(result.length, 1);
      expect(result.first.expression, '2+3');
    });
  });

  group('clearHistory', () {
    test('should call datasource clearHistory', () async {
      when(() => mockDatasource.clearHistory()).thenAnswer((_) async {});

      await repository.clearHistory();

      verify(() => mockDatasource.clearHistory()).called(1);
    });
  });

  group('setDegreeMode', () {
    test('should toggle degree mode', () {
      repository.setDegreeMode(false);
      expect(repository.isDegree, false);

      repository.setDegreeMode(true);
      expect(repository.isDegree, true);
    });
  });
}