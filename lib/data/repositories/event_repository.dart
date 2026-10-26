import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mutta_web/data/models/event_content.dart';

class EventRepository {
  const new(this._bundle);

  final AssetBundle _bundle;

  static const assetPath = 'assets/content/event.json';

  Future<EventContent> load() async {
    final raw = await _bundle.loadString(assetPath);
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('El contenido del evento no es un objeto.');
    }
    return EventContent.fromJson(decoded);
  }
}
