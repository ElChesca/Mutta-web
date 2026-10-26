import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/data/models/event_content.dart';

class TaglineBand extends StatelessWidget {
  const new({required this.tagline, super.key});

  final TaglineContent tagline;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return ColoredBox(
      color: tokens.surfaceBase,
      child: ContentFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: tokens.spacing.xxl),
          child: Responsive(
            builder: (context, breakpoint) {
              final compact = breakpoint == AppBreakpoint.mobile;
              final lead = Text(
                tagline.lead,
                textAlign: TextAlign.center,
                style: taglineLeadStyle(compact: compact),
              );
              final mark = Text(
                tagline.mark,
                textAlign: TextAlign.center,
                style: taglineMarkStyle(compact: compact),
              );
              final gap = SizedBox(
                width: tokens.spacing.md,
                height: tokens.spacing.sm,
              );
              return Semantics(
                label: '${tagline.lead} ${tagline.mark}',
                child: ExcludeSemantics(
                  child: compact
                      ? Column(children: [lead, gap, mark])
                      : Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: tokens.spacing.md,
                          runSpacing: tokens.spacing.sm,
                          children: [lead, mark],
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
