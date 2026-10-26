import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';

class SectionHeading extends StatelessWidget {
  const new({
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.centered = false,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final align = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisSize: centered ? MainAxisSize.min : MainAxisSize.max,
          children: [
            MuttaMark(size: tokens.metrics.iconSm),
            SizedBox(width: tokens.spacing.sm),
            Flexible(
              child: BrandText(
                eyebrow,
                role: BrandRole.labelMd,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: tokens.spacing.xs),
        BrandText(
          title,
          role: context.viewport.compact
              ? BrandRole.headlineMd
              : BrandRole.headlineLg,
          heading: true,
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          SizedBox(height: tokens.spacing.sm),
          BrandText(
            subtitle!,
            role: BrandRole.bodyMd,
            color: context.colors.onSurfaceVariant,
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}
