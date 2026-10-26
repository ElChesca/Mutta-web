import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/data/repositories/event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository(rootBundle);
});

final eventContentProvider = FutureProvider<EventContent>((ref) {
  return ref.watch(eventRepositoryProvider).load();
});

final eventStartsAtProvider = Provider<DateTime>((ref) {
  final content = ref.watch(eventContentProvider).asData?.value;
  return content?.event.startsAt ?? DateTime.utc(2026, 12, 19, 20);
});
