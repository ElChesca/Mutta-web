import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';

enum PillTone { neutral, gold, error, inverse }

class StatusPill extends StatelessWidget {
  const new({
    required this.label,
    this.tone = PillTone.neutral,
    this.icon,
    super.key,
  });

  final String label;
  final PillTone tone;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tokens = context.tokens;
    final (background, foreground) = switch (tone) {
      PillTone.neutral => (colors.surfaceContainer, colors.onSurfaceVariant),
      PillTone.gold => (colors.surfaceContainerHighest, colors.primary),
      PillTone.error => (
        colors.errorContainer.withValues(alpha: 0.3),
        colors.error,
      ),
      PillTone.inverse => (colors.primary, colors.onPrimary),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(tokens.radii.pill),
        border: tone == PillTone.gold
            ? Border.all(color: colors.primary.withValues(alpha: 0.2))
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.sm,
          vertical: tokens.spacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: tokens.spacing.xs)],
            BrandText(label, role: BrandRole.labelSm, color: foreground),
          ],
        ),
      ),
    );
  }
}
