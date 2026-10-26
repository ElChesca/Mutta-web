import 'package:flutter/material.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/data/models/event_content.dart';

class FaqTile extends StatelessWidget {
  const new({
    required this.item,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final FaqItem item;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(tokens.radii.card),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              button: true,
              expanded: expanded,
              label: item.question,
              child: InkWell(
                key: Key('faq-toggle-${item.id}'),
                onTap: onToggle,
                borderRadius: BorderRadius.circular(tokens.radii.nested),
                child: ExcludeSemantics(
                  child: Row(
                    children: [
                      Expanded(
                        child: BrandText(
                          item.question,
                          role: BrandRole.headlineSm,
                        ),
                      ),
                      SizedBox(width: tokens.spacing.sm),
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: Icon(
                          muttaIcon('expand_more'),
                          color: colors.primary,
                          size: tokens.metrics.iconLg,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Padding(
                padding: EdgeInsets.only(top: tokens.spacing.sm),
                child: BrandText(
                  item.answer,
                  role: BrandRole.bodySm,
                  color: colors.onSurfaceVariant,
                ),
              ),
              crossFadeState: expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 180),
            ),
          ],
        ),
      ),
    );
  }
}
