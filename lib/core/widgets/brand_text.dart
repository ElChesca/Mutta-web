import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

enum BrandRole {
  display,
  edition,
  headlineLg,
  headlineMd,
  headlineSm,
  bodyLg,
  bodyMd,
  bodySm,
  labelLg,
  labelMd,
  labelSm,
}

class BrandText extends StatelessWidget {
  const new(
    this.data, {
    required this.role,
    this.color,
    this.maxLines,
    this.textAlign,
    this.heading = false,
    super.key,
  });

  final String data;
  final BrandRole role;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool heading;

  bool get _upper => switch (role) {
    BrandRole.display ||
    BrandRole.edition ||
    BrandRole.headlineLg ||
    BrandRole.headlineMd ||
    BrandRole.headlineSm ||
    BrandRole.labelLg ||
    BrandRole.labelMd ||
    BrandRole.labelSm => true,
    BrandRole.bodyLg || BrandRole.bodyMd || BrandRole.bodySm => false,
  };

  @override
  Widget build(BuildContext context) {
    final texts = context.texts;
    final desktop = AppLayout.maybeOf(context) == AppBreakpoint.desktop;
    final style = switch (role) {
      BrandRole.display => desktop ? texts.displayLarge : texts.displayMedium,
      BrandRole.edition =>
        desktop
            ? texts.displaySmall
            : texts.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: 24 * 0.2,
                color: context.colors.primary,
              ),
      BrandRole.headlineLg => texts.headlineLarge,
      BrandRole.headlineMd => texts.headlineMedium,
      BrandRole.headlineSm => texts.headlineSmall,
      BrandRole.bodyLg => texts.bodyLarge,
      BrandRole.bodyMd => texts.bodyMedium,
      BrandRole.bodySm => texts.bodySmall,
      BrandRole.labelLg => texts.labelLarge,
      BrandRole.labelMd => texts.labelMedium,
      BrandRole.labelSm => texts.labelSmall,
    }?.copyWith(color: color);
    final text = Text(
      _upper ? data.toUpperCase() : data,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
    );
    if (!heading) {
      return text;
    }
    return Semantics(header: true, child: text);
  }
}
