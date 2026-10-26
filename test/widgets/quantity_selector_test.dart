import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mutta_web/core/format/ars_money.dart';
import 'package:mutta_web/data/providers.dart';
import 'package:mutta_web/features/landing/presentation/widgets/checkout_bar.dart';
import 'package:mutta_web/features/landing/presentation/widgets/quantity_selector.dart';

import '../support/harness.dart';

IconButton stepButton(WidgetTester tester, String tooltip) {
  return tester.widget<IconButton>(
    find.ancestor(
      of: find.byTooltip(tooltip),
      matching: find.byType(IconButton),
    ),
  );
}

void main() {
  testWidgets('el selector respeta el mínimo y el máximo', (tester) async {
    var quantity = 1;
    Future<void> pump() {
      return tester.pumpWidget(
        testSurface(
          QuantitySelector(
            quantity: quantity,
            onChanged: (value) => quantity = value,
          ),
          size: const Size(280, 120),
        ),
      );
    }

    await tester.binding.setSurfaceSize(const Size(360, 200));
    await pump();
    expect(find.text('1'), findsOneWidget);
    expect(stepButton(tester, 'Quitar pase').onPressed, isNull);

    await tester.tap(find.byTooltip('Agregar pase'));
    await pump();
    expect(quantity, 2);
    expect(find.text('2'), findsOneWidget);

    quantity = 10;
    await pump();
    expect(stepButton(tester, 'Agregar pase').onPressed, isNull);
    await tester.tap(find.byTooltip('Quitar pase'));
    await pump();
    expect(quantity, 9);
  });

  testWidgets('el total del checkout sigue la cantidad', (tester) async {
    final content = await loadEventContent();
    await tester.binding.setSurfaceSize(const Size(1100, 400));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [eventContentProvider.overrideWith((ref) async => content)],
        child: testSurface(
          CheckoutPanel(copy: content.passes.checkout, onPay: () {}),
          size: const Size(980, 280),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(r'$35.000 ARS'), findsOneWidget);
    expect(
      find.text('1x Entrada Individual con acceso Fast Pass'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Agregar pase'));
    await tester.pump();
    expect(find.text('2'), findsWidgets);
    expect(find.text(formatArsTotal(70000)), findsOneWidget);
    expect(find.text('2x VIP Sunset Terrace seleccionado'), findsOneWidget);

    await tester.tap(find.byTooltip('Quitar pase'));
    await tester.pump();
    expect(find.text(r'$35.000 ARS'), findsOneWidget);
  });
}
