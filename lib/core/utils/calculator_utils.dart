
class CalculatorUtils {
  static bool isOperator(String value) {
    return ['+', '-', '×', '÷', '%'].contains(value);
  }

  static bool isFunction(String value) {
    return [
      'sin(', 'cos(', 'tan(',
      'sinh(', 'cosh(', 'tanh(',
      'log(', 'ln(', 'sqrt(',
    ].contains(value);
  }

  static String formatResult(double result) {
    if (result == result.truncateToDouble()) {
      return result.toInt().toString();
    }
    return double.parse(result.toStringAsFixed(10)).toString();
  }

 static String sanitizeExpression(String expression, {bool isDegree = true}) {
    String sanitized = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '3.141592653589793')
        .replaceAll('ln(', 'log(');

    if (isDegree) {
      // Use negative lookahead pattern — replace only sin( not sinh(
      sanitized = sanitized
          .replaceAll('sinh(', '__SINH__')
          .replaceAll('cosh(', '__COSH__')
          .replaceAll('tanh(', '__TANH__')
          .replaceAll('sin(', 'sin(pi/180*')
          .replaceAll('cos(', 'cos(pi/180*')
          .replaceAll('tan(', 'tan(pi/180*')
          .replaceAll('__SINH__', 'sinh(')
          .replaceAll('__COSH__', 'cosh(')
          .replaceAll('__TANH__', 'tanh(');
    }

    return sanitized;
  }

  static bool isValidExpression(String expression) {
    if (expression.isEmpty) return false;
    final operators = ['+', '-', '*', '/'];
    if (operators.contains(expression[expression.length - 1])) return false;
    return true;
  }
}