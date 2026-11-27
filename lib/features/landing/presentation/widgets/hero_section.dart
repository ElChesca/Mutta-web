import 'package:material_ui/material_ui.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/countdown_readout.dart';

class HeroSection extends StatelessWidget {
  const new({
    required this.hero,
    required this.tagline,
    required this.onTickets,
    required this.onNext,
    super.key,
  });

  final HeroContent hero;
  final TaglineContent tagline;
  final VoidCallback onTickets;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final viewport = context.viewport;
    final header = viewport.metrics.headerHeight;
    final screen = MediaQuery.sizeOf(context).height;
    final minHeight = screen - header;
    return Stack(
      children: [
        const Positioned.fill(child: _HeroBackdrop()),
        ContentFrame(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: tokens.spacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BrandText(
                    hero.badge,
                    role: BrandRole.labelMd,
                    color: context.colors.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: tokens.spacing.lg),
                  MuttaMark(size: viewport.heroEmblem),
                  SizedBox(height: tokens.spacing.md),
                  BrandText(
                    hero.edition,
                    role: BrandRole.labelMd,
                    color: context.colors.primary,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  MuttaWordmark(
                    text: hero.title,
                    fontSize: viewport.metrics.wordmarkHero,
                  ),
                  SizedBox(height: tokens.spacing.md),
                  BrandText(
                    '${tagline.lead} ${tagline.mark}',
                    role: BrandRole.labelLg,
                    color: context.colors.onSurface,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  BrandText(
                    '${hero.dateLine} · ${hero.venueLine}',
                    role: BrandRole.bodyMd,
                    color: context.colors.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: tokens.spacing.xl),
                  MuttaButton(
                    label: hero.primaryCta,
                    onPressed: onTickets,
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.spacing.xl,
                      vertical: tokens.spacing.md,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.xl),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: CountdownPanel(
                      label: hero.countdownLabel,
                      units: hero.countdownUnits,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.lg),
                  TextButton(
                    onPressed: onNext,
                    child: BrandText(
                      hero.secondaryCta,
                      role: BrandRole.labelMd,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// El teaser actual todavía dice MUTTA, así que el fondo es el degradado
/// del afiche hasta que llegue un loop nuevo.
class _HeroBackdrop extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            tokens.surfaceBase,
            tokens.surfaceSubtle,
            tokens.accent.withValues(alpha: 0.28),
            tokens.surfaceBase,
          ],
          stops: const [0, 0.42, 0.72, 1],
        ),
      ),
    );
  }
}
