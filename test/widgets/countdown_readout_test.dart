import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mutta_web/features/landing/logic/countdown.dart';
import 'package:mutta_web/features/landing/presentation/widgets/countdown_readout.dart';

import '../support/harness.dart';

void main() {
  test('calcula días, horas, minutos y segundos', () {
    final now = DateTime.utc(2026, 12, 1, 12);
    final target = DateTime.utc(2026, 12, 19, 20);
    final value = CountdownValue.until(target, now);
    expect(value.days, 18);
    expect(value.hours, 8);
    expect(value.minutes, 0);
    expect(value.seconds, 0);
    expect(value.isComplete, isFalse);
    expect(CountdownValue.until(now, target).isComplete, isTrue);
  });

  testWidgets('muestra el conteo con etiquetas del evento', (tester) async {
    const value = CountdownValue(
      days: 54,
      hours: 3,
      minutes: 7,
      seconds: 8,
      isComplete: false,
    );
    await tester.binding.setSurfaceSize(const Size(640, 280));
    await tester.pumpWidget(
      testSurface(
        const CountdownReadout(
          value: value,
          label: 'Tiempo restante para el ritual',
          units: ['Días', 'Horas', 'Mins', 'Segs'],
        ),
        size: const Size(560, 220),
      ),
    );
    expect(find.text('54'), findsOneWidget);
    expect(find.text('03'), findsOneWidget);
    expect(find.text('07'), findsOneWidget);
    expect(find.text('08'), findsOneWidget);
    expect(find.text('DÍAS'), findsOneWidget);
    expect(find.text('HORAS'), findsOneWidget);
    expect(find.text('MINS'), findsOneWidget);
    expect(find.text('SEGS'), findsOneWidget);
    expect(
      tester.getSemantics(find.byType(CountdownReadout)),
      isSemantics(label: value.spoken),
    );
  });
}
