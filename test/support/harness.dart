import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/data/repositories/event_repository.dart';

Future<EventContent> loadEventContent() {
  return EventRepository(rootBundle).load();
}

Widget testSurface(Widget child, {Size size = const Size(800, 1400)}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: muttaTheme(),
    home: AppLayout(
      breakpoint: breakpointFor(size.width),
      child: Scaffold(
        body: Center(
          child: SizedBox(width: size.width, child: child),
        ),
      ),
    ),
  );
}
