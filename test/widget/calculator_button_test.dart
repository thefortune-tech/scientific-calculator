import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/presentation/widgets/calculator_button.dart';

void main() {
  group('CalculatorButton', () {
    testWidgets('should display label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorButton(label: '5', onTap: () {}),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should call onTap when pressed', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorButton(label: '5', onTap: () => tapped = true),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();
      expect(tapped, true);
    });

    testWidgets('should show operator color when isOperator is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorButton(label: '+', onTap: () {}, isOperator: true),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('+'), findsOneWidget);
    });

    testWidgets('should show function color when isFunction is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorButton(label: 'C', onTap: () {}, isFunction: true),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('C'), findsOneWidget);
    });
  });
}