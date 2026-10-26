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
    expect(content.passes.tiers.map((tier) => tier.name), [
      'General Access',
      'VIP Sunset Terrace',
      'Backstage Lounge',
    ]);
    expect(content.passes.tiers[1].priceArs, 35000);
    expect(
      content.faq.items.first.question,
      '¿A qué hora se recomienda llegar a Boxes?',
    );
    expect(content.event.startsAt.toUtc(), DateTime.utc(2026, 12, 19, 20));
    expect(content.footer.legal, contains('© 2025 MUTTA Experiences'));
  });
}
