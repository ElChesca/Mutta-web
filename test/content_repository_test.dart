import 'package:flutter_test/flutter_test.dart';

import 'support/harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('el JSON conserva los textos del mockup', () async {
    final content = await loadEventContent();
    expect(content.hero.quote, '“¿Más de lo mismo? MUTTA.”');
    expect(
      content.hero.dateLine,
      'Sábado 19 de Diciembre • Open Doors 17:00 hs',
    );
    expect(content.tagline.lead, '¿MÁS DE LO MISMO?');
    expect(content.tagline.mark, 'MUTTA.');
    expect(
      content.navigation.map((item) => item.section),
      isNot(contains('passes')),
    );
    expect(
      content.faq.items.first.question,
      '¿A qué hora se recomienda llegar a Boxes?',
    );
    expect(content.event.startsAt.toUtc(), DateTime.utc(2026, 12, 19, 20));
    expect(content.footer.legal, contains('© 2025 MUTTA Experiences'));
  });
}
