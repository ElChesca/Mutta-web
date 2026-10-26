String formatArsAmount(int value) {
  final negative = value < 0;
  final digits = value.abs().toString();
  final groups = <String>[];
  for (var end = digits.length; end > 0; end -= 3) {
    final start = end - 3 < 0 ? 0 : end - 3;
    groups.add(digits.substring(start, end));
  }
  final body = groups.reversed.join('.');
  return '${negative ? '-' : ''}\$$body';
}

String formatArsTotal(int value) => '${formatArsAmount(value)} ARS';
