import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/core/widgets/status_pill.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/asset_cover.dart';
import 'package:mutta_web/features/landing/presentation/widgets/countdown_readout.dart';

class HeroSection extends StatelessWidget {
  const new({
    required this.hero,
    required this.lockup,
    required this.onTickets,
    required this.onLineup,
    super.key,
  });

  final HeroContent hero;
  final String lockup;
  final VoidCallback onTickets;
  final VoidCallback onLineup;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Stack(
      children: [
        const Positioned.fill(child: _HeroGlow()),
        Positioned.fill(
          child: IgnorePointer(
            child: Responsive(
              builder: (context, breakpoint) {
                if (breakpoint != AppBreakpoint.desktop) {
                  return const SizedBox.shrink();
                }
                return Align(
                  alignment: Alignment.centerRight,
                  child: Opacity(
                    opacity: 0.035,
                    child: MuttaMark(size: tokens.metrics.watermark),
                  ),
                );
              },
            ),
          ),
        ),
        ContentFrame(
          child: Padding(
            padding: EdgeInsets.only(
              top: tokens.spacing.xl,
              bottom: tokens.spacing.xxl,
            ),
            child: Responsive(
              builder: (context, breakpoint) {
                final wide = breakpoint == AppBreakpoint.desktop;
                final copy = _HeroCopy(
                  hero: hero,
                  lockup: lockup,
                  onTickets: onTickets,
                  onLineup: onLineup,
                );
                final poster = _Poster(hero: hero);
                if (!wide) {
                  return Column(
                    children: [
                      copy,
                      SizedBox(height: tokens.spacing.lg),
                      poster,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(flex: 7, child: copy),
                    SizedBox(width: tokens.spacing.gutterDesktop),
                    Expanded(flex: 5, child: poster),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroGlow extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.8),
            radius: 0.9,
            colors: [context.tokens.accentWash, const Color(0x00000000)],
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const new({
    required this.hero,
    required this.lockup,
    required this.onTickets,
    required this.onLineup,
  });

  final HeroContent hero;
  final String lockup;
  final VoidCallback onTickets;
  final VoidCallback onLineup;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusPill(
          label: hero.badge,
          icon: MuttaMark(size: tokens.metrics.iconSm),
        ),
        SizedBox(height: tokens.spacing.lg),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: tokens.spacing.lg,
          children: [
            MuttaLockup(
              height: tokens.metrics.wordmarkHero,
              tagline: lockup,
              semanticLabel: hero.title,
            ),
            BrandText(hero.edition, role: BrandRole.edition),
          ],
        ),
        SizedBox(height: tokens.spacing.xs),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: tokens.spacing.sm,
          children: [
            BrandText(hero.dateLine, role: BrandRole.headlineSm),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(dimension: tokens.metrics.pulse),
            ),
            BrandText(
              hero.venueLine,
              role: BrandRole.headlineSm,
              color: colors.primary,
            ),
          ],
        ),
        SizedBox(height: tokens.spacing.lg),
        _Highlight(hero: hero),
        SizedBox(height: tokens.spacing.lg),
        Text(
          hero.quote,
          style: context.texts.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
            color: colors.onSurface,
          ),
        ),
        SizedBox(height: tokens.spacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: BrandText(
            hero.description,
            role: BrandRole.bodyMd,
            color: colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: tokens.spacing.lg),
        CountdownPanel(label: hero.countdownLabel, units: hero.countdownUnits),
        SizedBox(height: tokens.spacing.lg),
        Wrap(
          spacing: tokens.spacing.md,
          runSpacing: tokens.spacing.md,
          children: [
            MuttaButton(
              label: hero.primaryCta,
              icon: muttaIcon('confirmation_number'),
              onPressed: onTickets,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.xl,
                vertical: tokens.spacing.md,
              ),
            ),
            MuttaButton(
              label: hero.secondaryCta,
              variant: MuttaButtonVariant.tonal,
              trailingIcon: muttaIcon('expand_more'),
              onPressed: onLineup,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.lg,
                vertical: tokens.spacing.md,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  const new({required this.hero});

  final HeroContent hero;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(tokens.radii.card),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: tokens.metrics.playButton + tokens.spacing.sm,
                child: Icon(
                  muttaIcon('graphic_eq'),
                  color: colors.primary,
                  size: tokens.metrics.iconLg,
                ),
              ),
            ),
            SizedBox(width: tokens.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandText(hero.highlightEyebrow, role: BrandRole.labelSm),
                  BrandText(hero.highlightName, role: BrandRole.headlineMd),
                  BrandText(hero.highlightSubtitle, role: BrandRole.bodySm),
                ],
              ),
            ),
            Responsive(
              builder: (context, breakpoint) {
                if (breakpoint == AppBreakpoint.mobile) {
                  return const SizedBox.shrink();
                }
                return StatusPill(
                  label: hero.highlightBadge,
                  tone: PillTone.gold,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const new({required this.hero});

  final HeroContent hero;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Stack(
          alignment: Alignment.center,
          children: [
            IgnorePointer(
              child: Container(
                width: context.tokens.metrics.headlinerPhotoHeight,
                height: context.tokens.metrics.headlinerPhotoHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.25),
                      const Color(0x00000000),
                    ],
                  ),
                ),
              ),
            ),
            RepaintBoundary(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(tokens.radii.xl),
                  border: Border.all(
                    color: colors.outlineVariant.withValues(alpha: 0.3),
                  ),
                  boxShadow: tokens.posterShadow,
                ),
                child: Padding(
                  padding: EdgeInsets.all(tokens.spacing.xs),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(tokens.radii.card),
                    child: AspectRatio(
                      aspectRatio: tokens.metrics.posterAspect,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AssetCover(
                            asset: hero.posterImage,
                            alt: hero.posterAlt,
                          ),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0x000E0E0E), Color(0xCC0E0E0E)],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(tokens.spacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StatusPill(
                                  label: hero.posterBadge,
                                  icon: MuttaMark(size: tokens.metrics.iconSm),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BrandText(
                                            hero.posterLocationLabel,
                                            role: BrandRole.labelSm,
                                            color: colors.primary,
                                          ),
                                          BrandText(
                                            hero.posterLocation,
                                            role: BrandRole.headlineSm,
                                          ),
                                          BrandText(
                                            hero.posterLocationDetail,
                                            role: BrandRole.bodySm,
                                          ),
                                        ],
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: colors.surfaceContainerHigh
                                            .withValues(alpha: 0.9),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: colors.primary.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                      ),
                                      child: SizedBox.square(
                                        dimension: tokens.metrics.playButton,
                                        child: Icon(
                                          muttaIcon('pin_drop'),
                                          color: colors.primary,
                                          size: tokens.metrics.iconMd,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
