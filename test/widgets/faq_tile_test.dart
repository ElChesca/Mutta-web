import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/faq_tile.dart';

import '../support/harness.dart';

void main() {
  const item = FaqItem(
    id: 'faq-1',
    question: '¿A qué hora se recomienda llegar a Boxes?',
    answer: 'Recomendamos ingresar a las 17:00 hs puntual.',
    initiallyExpanded: true,
  );

  testWidgets('expande y colapsa la respuesta', (tester) async {
    var expanded = true;
    Future<void> pump() {
      return tester.pumpWidget(
        testSurface(
          FaqTile(
            item: item,
            expanded: expanded,
            onToggle: () => expanded = !expanded,
          ),
          size: const Size(480, 320),
        ),
      );
    }

    await tester.binding.setSurfaceSize(const Size(520, 360));
    await pump();
    expect(find.textContaining('17:00 hs puntual'), findsOneWidget);
    expect(
      tester.getSemantics(find.byKey(const Key('faq-toggle-faq-1'))),
      isSemantics(isButton: true, isExpanded: true, hasTapAction: true),
    );

    await tester.tap(find.byKey(const Key('faq-toggle-faq-1')));
    await pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.textContaining('17:00 hs puntual').hitTestable(), findsNothing);
    expect(
      tester.getSemantics(find.byKey(const Key('faq-toggle-faq-1'))),
      isSemantics(isButton: true, isExpanded: false),
    );
  });
}
