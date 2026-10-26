import 'package:flutter/material.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/core/widgets/status_pill.dart';
import 'package:mutta_web/core/widgets/text_runs_view.dart';
import 'package:mutta_web/data/models/event_content.dart';

class ExperienceSection extends StatelessWidget {
  const new({required this.experience, super.key});

  final ExperienceContent experience;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return ColoredBox(
      color: tokens.surfaceSection,
      child: ContentFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: tokens.spacing.xxl),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: SectionHeading(
                  eyebrow: experience.eyebrow,
                  title: experience.title,
                  subtitle: experience.intro,
                  centered: true,
                ),
              ),
              SizedBox(height: tokens.spacing.xxl),
              _IsotipoBlock(isotipo: experience.isotipo),
              SizedBox(height: tokens.spacing.xxl),
              Responsive(
                builder: (context, breakpoint) {
                  final pillars = [
                    for (final pillar in experience.pillars)
                      _PillarCard(pillar: pillar),
                  ];
                  if (breakpoint == AppBreakpoint.mobile) {
                    return Column(
                      children: [
                        for (final card in pillars) ...[
                          card,
                          SizedBox(height: tokens.spacing.gutterDesktop),
                        ],
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < pillars.length; i++) ...[
                        if (i > 0)
                          SizedBox(width: tokens.spacing.gutterDesktop),
                        Expanded(child: pillars[i]),
                      ],
                    ],
                  );
                },
              ),
              SizedBox(height: tokens.spacing.xxl),
              _Wristband(wristband: experience.wristband),
            ],
          ),
        ),
      ),
    );
  }
}

class _IsotipoBlock extends StatelessWidget {
  const new({required this.isotipo});

  final IsotipoContent isotipo;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tokens.radii.xl),
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surfaceContainer,
            colors.surfaceContainerLow,
            colors.surfaceContainerLowest,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.xl),
        child: Responsive(
          builder: (context, breakpoint) {
            final coin = _Coin(isotipo: isotipo);
            final copy = _IsotipoCopy(isotipo: isotipo);
            if (breakpoint != AppBreakpoint.desktop) {
              return Column(
                children: [
                  coin,
                  SizedBox(height: tokens.spacing.xl),
                  copy,
                ],
              );
            }
            return Row(
              children: [
                Expanded(flex: 4, child: coin),
                SizedBox(width: tokens.spacing.xl),
                Expanded(flex: 8, child: copy),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Coin extends StatelessWidget {
  const new({required this.isotipo});

  final IsotipoContent isotipo;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Column(
      children: [
        Responsive(
          builder: (context, breakpoint) {
            final size = breakpoint == AppBreakpoint.mobile
                ? tokens.metrics.isotipoCompact
                : tokens.metrics.isotipo;
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tokens.surfaceBase,
                border: Border.all(color: colors.primary, width: 2),
                boxShadow: tokens.buttonGlow,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(tokens.spacing.sm),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  MuttaMark(
                    color: colors.onSurface,
                    size: size * 0.46,
                    semanticLabel: isotipo.badge,
                  ),
                  Positioned(
                    bottom: tokens.spacing.sm,
                    child: StatusPill(
                      label: isotipo.badge,
                      tone: PillTone.gold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: tokens.spacing.md),
        Wrap(
          spacing: tokens.spacing.sm,
          runSpacing: tokens.spacing.sm,
          alignment: WrapAlignment.center,
          children: [
            StatusPill(label: isotipo.monochromeLabel),
            StatusPill(label: isotipo.sunsetLabel, tone: PillTone.gold),
          ],
        ),
      ],
    );
  }
}

class _IsotipoCopy extends StatelessWidget {
  const new({required this.isotipo});

  final IsotipoContent isotipo;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(muttaIcon('verified'), color: colors.primary),
            SizedBox(width: tokens.spacing.xs),
            Flexible(
              child: BrandText(
                isotipo.eyebrow,
                role: BrandRole.labelSm,
                color: colors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: tokens.spacing.sm),
        BrandText(isotipo.title, role: BrandRole.headlineLg, heading: true),
        SizedBox(height: tokens.spacing.sm),
        TextRunsView(isotipo.body, role: context.texts.bodyMedium),
        SizedBox(height: tokens.spacing.md),
        Responsive(
          builder: (context, breakpoint) {
            final cards = [
              for (final point in isotipo.points) _PointCard(point: point),
            ];
            if (breakpoint == AppBreakpoint.mobile) {
              return Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    SizedBox(height: tokens.spacing.md),
                  ],
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: cards.first),
                SizedBox(width: tokens.spacing.md),
                Expanded(child: cards.last),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PointCard extends StatelessWidget {
  const new({required this.point});

  final IsotipoPoint point;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(tokens.radii.card),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: tokens.metrics.qtyButton,
                child: Center(
                  child: point.icon == 'mark'
                      ? MuttaMark(
                          color: colors.primary,
                          size: tokens.metrics.iconSm,
                        )
                      : Icon(
                          muttaIcon(point.icon),
                          color: colors.primary,
                          size: tokens.metrics.iconMd,
                        ),
                ),
              ),
            ),
            SizedBox(width: tokens.spacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandText(point.title, role: BrandRole.labelMd),
                  BrandText(point.body, role: BrandRole.bodySm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PillarCard extends StatelessWidget {
  const new({required this.pillar});

  final Pillar pillar;

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
        padding: EdgeInsets.all(tokens.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: tokens.metrics.pillarIcon,
                child: Icon(
                  muttaIcon(pillar.icon),
                  color: colors.primary,
                  size: tokens.metrics.iconLg,
                ),
              ),
            ),
            SizedBox(height: tokens.spacing.md),
            BrandText(pillar.title, role: BrandRole.headlineMd),
            SizedBox(height: tokens.spacing.sm),
            BrandText(
              pillar.body,
              role: BrandRole.bodySm,
              color: colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _Wristband extends StatelessWidget {
  const new({required this.wristband});

  final WristbandContent wristband;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(tokens.radii.xl),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.xl),
        child: Responsive(
          builder: (context, breakpoint) {
            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MuttaMark(
                      color: colors.primary,
                      size: tokens.metrics.iconSm,
                    ),
                    SizedBox(width: tokens.spacing.sm),
                    Flexible(
                      child: BrandText(
                        wristband.eyebrow,
                        role: BrandRole.labelSm,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacing.xs),
                BrandText(wristband.title, role: BrandRole.headlineLg),
                SizedBox(height: tokens.spacing.xs),
                TextRunsView(
                  wristband.body,
                  role: context.texts.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            );
            final badge = _OfficialBadge(wristband: wristband);
            if (breakpoint == AppBreakpoint.mobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  copy,
                  SizedBox(height: tokens.spacing.xl),
                  badge,
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: copy),
                SizedBox(width: tokens.spacing.xl),
                badge,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OfficialBadge extends StatelessWidget {
  const new({required this.wristband});

  final WristbandContent wristband;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(tokens.radii.xl),
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: tokens.metrics.artistThumb + tokens.spacing.md,
              height: tokens.metrics.artistThumb + tokens.spacing.md,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tokens.surfaceBase,
                border: Border.all(color: colors.primary, width: 2),
                boxShadow: tokens.goldenGlow,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MuttaMark(
                    color: colors.onSurface,
                    size: tokens.metrics.playButton + tokens.spacing.xs,
                  ),
                  Positioned(
                    bottom: 0,
                    child: StatusPill(
                      label: wristband.official,
                      tone: PillTone.inverse,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: tokens.spacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandText(wristband.brand, role: BrandRole.headlineSm),
                BrandText(wristband.meta, role: BrandRole.labelSm),
                BrandText(
                  wristband.note,
                  role: BrandRole.labelSm,
                  color: colors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
