import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

class ContentFrame extends StatelessWidget {
  const new({required this.child, this.bottom, super.key});

  final Widget child;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Responsive(
      builder: (context, breakpoint) {
        final margin = switch (breakpoint) {
          AppBreakpoint.mobile => tokens.spacing.margin,
          AppBreakpoint.tablet => tokens.spacing.marginTablet,
          AppBreakpoint.desktop => tokens.spacing.marginDesktop,
        };
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: tokens.metrics.maxWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(margin, 0, margin, bottom ?? 0),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
