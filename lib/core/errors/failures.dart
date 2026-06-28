import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class CalculationFailure extends Failure {
  const CalculationFailure({required super.message});
}

class StorageFailure extends Failure {
  const StorageFailure({required super.message});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required super.message});
}