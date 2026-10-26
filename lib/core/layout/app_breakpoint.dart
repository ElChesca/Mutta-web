import 'package:flutter/widgets.dart';

enum AppBreakpoint { mobile, tablet, desktop }

AppBreakpoint breakpointFor(double width) {
  if (width < 768) {
    return AppBreakpoint.mobile;
  }
  if (width <= 1024) {
    return AppBreakpoint.tablet;
  }
  return AppBreakpoint.desktop;
}

class AppLayout extends InheritedWidget {
  const new({required this.breakpoint, required super.child, super.key});

  final AppBreakpoint breakpoint;

  static AppBreakpoint? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLayout>()?.breakpoint;
  }

  static AppBreakpoint of(BuildContext context) {
    final value = maybeOf(context);
    assert(value != null, 'AppLayout no está en el árbol.');
    return value!;
  }

  @override
  bool updateShouldNotify(AppLayout oldWidget) {
    return breakpoint != oldWidget.breakpoint;
  }
}

class Responsive extends StatelessWidget {
  const new({required this.builder, super.key});

  final Widget Function(BuildContext context, AppBreakpoint breakpoint) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inherited = AppLayout.maybeOf(context);
        final breakpoint = inherited ?? breakpointFor(constraints.maxWidth);
        return builder(context, breakpoint);
      },
    );
  }
}
