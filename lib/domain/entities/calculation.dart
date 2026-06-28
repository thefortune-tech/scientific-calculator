import 'package:equatable/equatable.dart';

class Calculation extends Equatable {
  final String id;
  final String expression;
  final String result;
  final DateTime timestamp;

  const Calculation({
    required this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  @override
  List<Object> get props => [id, expression, result, timestamp];
}