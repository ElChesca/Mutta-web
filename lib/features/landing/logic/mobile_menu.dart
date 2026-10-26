import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileMenuNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void close() => state = false;
}

final mobileMenuProvider = NotifierProvider<MobileMenuNotifier, bool>(
  MobileMenuNotifier.new,
);
