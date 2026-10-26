import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/data/providers.dart';

class FaqNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    final content = ref.watch(eventContentProvider).asData?.value;
    final items = content?.faq.items;
    if (items == null) {
      return {};
    }
    return {
      for (final item in items)
        if (item.initiallyExpanded) item.id,
    };
  }

  void toggle(String id) {
    final next = {...state};
    if (!next.add(id)) {
      next.remove(id);
    }
    state = next;
  }
}

final faqProvider = NotifierProvider<FaqNotifier, Set<String>>(FaqNotifier.new);
