import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/presentation/widgets/calculator_display.dart';

void main() {
  group('CalculatorDisplay', () {
    testWidgets('should display expression and result', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(expression: '2+3', result: '5'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('2+3'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should display 0 when expression is empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(expression: '', result: '0'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('0'), findsWidgets);
    });
  });
}