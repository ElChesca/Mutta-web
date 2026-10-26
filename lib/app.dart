import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/router/app_router.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

class MuttaApp extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'MUTTA Sunset',
      debugShowCheckedModeBanner: false,
      theme: muttaTheme(),
      routerConfig: router,
    );
  }
}
