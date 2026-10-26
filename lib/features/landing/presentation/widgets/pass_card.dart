import 'package:flutter/material.dart';
import 'package:mutta_web/core/format/ars_money.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/core/widgets/status_pill.dart';
import 'package:mutta_web/data/models/event_content.dart';

class PassCard extends StatefulWidget {
  const new({required this.tier, required this.onSelect, super.key});

  final PassTier tier;
  final VoidCallback onSelect;

  @override
  State<PassCard> createState() => _PassCardState();
}

class _PassCardState extends State<PassCard> {
  var _hover = false;

  @override
  Widget build(BuildContext context) {
    final tier = widget.tier;
    final tokens = context.tokens;
    final colors = context.colors;
    final desktop = AppLayout.maybeOf(context) == AppBreakpoint.desktop;
    final background = tier.featured
        ? colors.surfaceContainer
        : (_hover ? colors.surfaceContainer : colors.surfaceContainerLow);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Transform.translate(
        offset: Offset(0, tier.featured && desktop ? -tokens.spacing.sm : 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(tokens.radii.card),
                border: Border.all(
                  color: tier.featured
                      ? colors.primary.withValues(alpha: 0.4)
                      : colors.outlineVariant.withValues(alpha: 0.2),
                  width: tier.featured ? 2 : 1,
                ),
                boxShadow: tier.featured ? tokens.goldenGlow : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(tokens.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: tokens.spacing.sm,
                            runSpacing: tokens.spacing.xs,
                            children: [
                              StatusPill(
                                label: tier.badgeLeft,
                                tone: tier.featured
                                    ? PillTone.gold
                                    : PillTone.neutral,
                              ),
                              if (tier.badgeRight != null)
                                StatusPill(
                                  label: tier.badgeRight!,
                                  tone: tier.badgeRightTone == 'error'
                                      ? PillTone.error
                                      : PillTone.neutral,
                                ),
                            ],
                          ),
                        ),
                        if (tier.featured) ...[
                          SizedBox(width: tokens.spacing.sm),
                          Icon(
                            muttaIcon('stars'),
                            color: colors.primary,
                            size: tokens.metrics.iconMd,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: tokens.spacing.md),
                    BrandText(tier.name, role: BrandRole.headlineMd),
                    SizedBox(height: tokens.spacing.xs),
                    BrandText(
                      tier.description,
                      role: BrandRole.bodySm,
                      color: colors.onSurfaceVariant,
                    ),
                    SizedBox(height: tokens.spacing.sm),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: tokens.spacing.xs,
                      children: [
                        Text(
                          formatArsAmount(tier.priceArs),
                          style: context.texts.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: tier.featured
                                ? colors.primary
                                : colors.onSurface,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: tokens.spacing.xs),
                          child: BrandText(
                            tier.priceSuffix,
                            role: BrandRole.labelMd,
                            color: tier.featured
                                ? colors.secondary
                                : colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing.sm),
                    for (final item in tier.includes) ...[
                      Padding(
                        padding: EdgeInsets.only(bottom: tokens.spacing.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              muttaIcon('check_circle'),
                              color: colors.primary,
                              size: tokens.metrics.iconMd,
                            ),
                            SizedBox(width: tokens.spacing.sm),
                            Expanded(
                              child: BrandText(
                                item,
                                role: BrandRole.bodySm,
                                color: tier.featured
                                    ? colors.onSurface
                                    : colors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: tokens.spacing.lg),
                    MuttaButton(
                      label: tier.cta,
                      expand: true,
                      variant: tier.featured
                          ? MuttaButtonVariant.primary
                          : MuttaButtonVariant.tonal,
                      onPressed: widget.onSelect,
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.spacing.lg,
                        vertical: tier.featured
                            ? tokens.spacing.md
                            : tokens.spacing.sm,
                      ),
                    ),
                    SizedBox(height: tokens.spacing.sm),
                    Center(
                      child: BrandText(
                        tier.footnote,
                        role: BrandRole.labelSm,
                        color: tier.featured
                            ? colors.primary.withValues(alpha: 0.8)
                            : colors.outline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (tier.ribbon != null)
              Positioned(
                top: -tokens.spacing.sm,
                left: 0,
                right: 0,
                child: Center(
                  child: StatusPill(
                    label: tier.ribbon!,
                    tone: PillTone.inverse,
                    icon: MuttaMark(
                      color: colors.onPrimary,
                      size: tokens.metrics.iconSm,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
