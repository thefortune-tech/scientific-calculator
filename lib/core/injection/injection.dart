import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/datasources/calculator_local_datasource.dart';
import '../../data/models/calculation_model.dart';
import '../../data/repositories/calculator_repository_impl.dart';
import '../../domain/repositories/calculator_repository.dart';
import '../../domain/usecases/clear_history.dart';
import '../../domain/usecases/evaluate_expression.dart';
import '../../domain/usecases/get_history.dart';
import '../../domain/usecases/save_calculation.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final box = await Hive.openBox<CalculationModel>(
    'calculator_history_box',
  );

  sl.registerLazySingleton<CalculatorLocalDatasource>(
    () => CalculatorLocalDatasourceImpl(box: box),
  );

  sl.registerLazySingleton<CalculatorRepository>(
    () => CalculatorRepositoryImpl(localDatasource: sl()),
  );

  sl.registerLazySingleton(() => EvaluateExpression(sl()));
  sl.registerLazySingleton(() => SaveCalculation(sl()));
  sl.registerLazySingleton(() => GetHistory(sl()));
  sl.registerLazySingleton(() => ClearHistory(sl()));
}