import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';

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
        if (eyebrow.isNotEmpty) ...[
          BrandText(
            eyebrow,
            role: BrandRole.labelMd,
            color: context.colors.primary,
            textAlign: textAlign,
          ),
          SizedBox(height: tokens.spacing.sm),
        ],
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
