import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/data/providers.dart';

typedef MuttaClock = DateTime Function();

final clockProvider = Provider<MuttaClock>((ref) => DateTime.now);

class CountdownValue {
  const new({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.isComplete,
  });

  factory until(DateTime target, DateTime now) {
    final difference = target.difference(now);
    if (!difference.isNegative && difference > Duration.zero) {
      return CountdownValue(
        days: difference.inDays,
        hours: difference.inHours.remainder(24),
        minutes: difference.inMinutes.remainder(60),
        seconds: difference.inSeconds.remainder(60),
        isComplete: false,
      );
    }
    return const CountdownValue(
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
      isComplete: true,
    );
  }

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final bool isComplete;

  String pad(int value) => value.toString().padLeft(2, '0');

  String get spoken {
    if (isComplete) {
      return 'El evento ya comenzó';
    }
    return 'Faltan $days días, $hours horas, '
        '$minutes minutos y $seconds segundos';
  }
}

class CountdownNotifier extends Notifier<CountdownValue> {
  Timer? _timer;

  @override
  CountdownValue build() {
    _timer?.cancel();
    final target = ref.watch(eventStartsAtProvider);
    final clock = ref.watch(clockProvider);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = CountdownValue.until(target, clock());
    });
    ref.onDispose(() => _timer?.cancel());
    return CountdownValue.until(target, clock());
  }
}

final countdownProvider = NotifierProvider<CountdownNotifier, CountdownValue>(
  CountdownNotifier.new,
);
