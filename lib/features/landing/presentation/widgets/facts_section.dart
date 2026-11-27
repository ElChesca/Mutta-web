import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/asset_cover.dart';

class FactsSection extends StatelessWidget {
  const new({required this.facts, super.key});

  final FactsContent facts;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final viewport = context.viewport;
    return ContentFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: viewport.sectionPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: BrandText(
                facts.title,
                role: viewport.compact
                    ? BrandRole.headlineMd
                    : BrandRole.headlineLg,
                heading: true,
              ),
            ),
            SizedBox(height: viewport.headingGap),
            Responsive(
              builder: (context, breakpoint) {
                final tiles = [
                  for (final item in facts.items) _Fact(item: item),
                ];
                if (breakpoint == AppBreakpoint.mobile) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < tiles.length; i++) ...[
                        if (i > 0) SizedBox(height: tokens.spacing.lg),
                        tiles[i],
                      ],
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < tiles.length; i++) ...[
                      if (i > 0) SizedBox(width: tokens.spacing.xl),
                      Expanded(child: tiles[i]),
                    ],
                  ],
                );
              },
            ),
            if (facts.image.isNotEmpty) ...[
              SizedBox(height: viewport.headingGap),
              ClipRRect(
                borderRadius: BorderRadius.circular(tokens.radii.card),
                child: AspectRatio(
                  aspectRatio: 16 / 7,
                  child: AssetCover(
                    asset: facts.image,
                    alt: facts.imageAlt,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const new({required this.item});

  final FactItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText(
          item.label,
          role: BrandRole.labelSm,
          color: context.colors.primary,
        ),
        SizedBox(height: context.tokens.spacing.sm),
        BrandText(item.value, role: BrandRole.headlineSm),
      ],
    );
  }
}
