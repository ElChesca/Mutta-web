import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/pass_card.dart';

import '../support/harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late EventContent content;

  setUpAll(() async {
    content = await loadEventContent();
  });

  Future<void> resetSurface(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.binding.setSurfaceSize(null);
  }

  testWidgets('la tarjeta general muestra precio, inclusiones y CTA', (
    tester,
  ) async {
    final general = content.passes.tiers.first;
    var selected = false;
    await tester.binding.setSurfaceSize(const Size(420, 900));
    await tester.pumpWidget(
      testSurface(
        PassCard(tier: general, onSelect: () => selected = true),
        size: const Size(380, 900),
      ),
    );
    expect(find.text('GENERAL ACCESS'), findsOneWidget);
    expect(find.text(r'$18.000'), findsOneWidget);
    expect(find.text('ARS'), findsOneWidget);
    expect(find.text('SELECCIONAR PASE'), findsOneWidget);
    expect(find.textContaining('Sunset Welcome Drink'), findsOneWidget);
    await tester.tap(find.text('SELECCIONAR PASE'));
    expect(selected, isTrue);
    await resetSurface(tester);
  });

  testWidgets('la tarjeta VIP muestra la cinta y el precio en oro', (
    tester,
  ) async {
    final vip = content.passes.tiers[1];
    await tester.binding.setSurfaceSize(const Size(420, 1000));
    await tester.pumpWidget(
      testSurface(
        PassCard(tier: vip, onSelect: () {}),
        size: const Size(380, 1000),
      ),
    );
    expect(find.text('LA ELECCIÓN MUTTA'), findsOneWidget);
    expect(find.text('VIP SUNSET TERRACE'), findsOneWidget);
    expect(find.text(r'$35.000'), findsOneWidget);
    expect(find.text('COMPRAR VIP TERRACE'), findsOneWidget);
    await resetSurface(tester);
  });
}
