import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/injection/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/models/calculation_model.dart';
import 'domain/repositories/calculator_repository.dart';
import 'domain/usecases/clear_history.dart';
import 'domain/usecases/evaluate_expression.dart';
import 'domain/usecases/get_history.dart';
import 'domain/usecases/save_calculation.dart';
import 'presentation/bloc/calculator_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CalculationModelAdapter());
  await initDependencies();
  runApp(const ScientIQApp());
}

class ScientIQApp extends StatelessWidget {
  const ScientIQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorBloc(
        evaluateExpression: sl<EvaluateExpression>(),
        saveCalculation: sl<SaveCalculation>(),
        getHistory: sl<GetHistory>(),
        clearHistory: sl<ClearHistory>(),
        repository: sl<CalculatorRepository>(),
      ),
      child: MaterialApp.router(
        title: 'ScientIQ',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}