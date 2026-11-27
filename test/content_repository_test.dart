import 'package:flutter_test/flutter_test.dart';

import 'support/harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('el JSON conserva los textos de MUTTÖ', () async {
    final content = await loadEventContent();
    expect(content.event.name, 'MUTTÖ');
    expect(content.chrome.brand, 'MUTTÖ');
    expect(content.hero.dateLine, 'Sábado 19 de diciembre');
    expect(content.tagline.lead, 'Todo muta.');
    expect(content.tagline.mark, 'Hasta nuestro nombre.');
    expect(content.footer.quote, 'Nos vemos al atardecer.');
    expect(content.facts.title, contains('progressive house'));
    expect(
      content.navigation.map((item) => item.section),
      isNot(contains('passes')),
    );
    expect(
      content.navigation.map((item) => item.section),
      isNot(contains('entradas')),
    );
    expect(
      content.faq.items.map((item) => item.answer).join(' '),
      isNot(contains('pulsera')),
    );
    expect(content.event.startsAt.toUtc(), DateTime.utc(2026, 12, 19, 20));
    expect(content.footer.legal, contains('MUTTÖ'));
    expect(content.footer.sponsors, containsAll(['Corona', 'Aperol']));
    expect(content.footer.producers, contains('Puerto Chapas'));
  });
}
