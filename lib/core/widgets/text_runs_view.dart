import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/data/models/event_content.dart';

class TextRunsView extends StatelessWidget {
  const new(this.runs, {required this.role, super.key});

  final List<TextRun> runs;
  final TextStyle? role;

  @override
  Widget build(BuildContext context) {
    final base = role ?? context.texts.bodyMedium;
    final gold = context.colors.primary;
    final cream = context.colors.onSurface;
    return Text.rich(
      TextSpan(
        style: base,
        children: [
          for (final run in runs)
            TextSpan(
              text: run.text,
              style: switch (run.emphasis) {
                'gold' => base?.copyWith(
                  color: gold,
                  fontWeight: FontWeight.w600,
                ),
                'cream' => base?.copyWith(
                  color: cream,
                  fontWeight: FontWeight.w500,
                ),
                _ => null,
              },
            ),
        ],
      ),
    );
  }
}
