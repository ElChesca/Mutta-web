import 'package:flutter/material.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/core/widgets/status_pill.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/asset_cover.dart';

class LineupSection extends StatelessWidget {
  const new({required this.lineup, required this.onOpenProfile, super.key});

  final LineupContent lineup;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Stack(
      children: [
        Positioned(
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.03,
              child: MuttaMark(size: tokens.metrics.headlinerPhotoHeight),
            ),
          ),
        ),
        ContentFrame(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: tokens.spacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeading(
                  eyebrow: lineup.eyebrow,
                  title: lineup.title,
                  subtitle: lineup.intro,
                ),
                SizedBox(height: tokens.spacing.xl),
                Responsive(
                  builder: (context, breakpoint) {
                    final headliner = _HeadlinerCard(artist: lineup.headliner);
                    final side = _SupportColumn(
                      artists: lineup.support,
                      soundTitle: lineup.soundTitle,
                      soundBody: lineup.soundBody,
                      onOpenProfile: onOpenProfile,
                    );
                    if (breakpoint != AppBreakpoint.desktop) {
                      return Column(
                        children: [
                          headliner,
                          SizedBox(height: tokens.spacing.gutterDesktop),
                          side,
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 8, child: headliner),
                        SizedBox(width: tokens.spacing.gutterDesktop),
                        Expanded(flex: 4, child: side),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeadlinerCard extends StatelessWidget {
  const new({required this.artist});

  final Headliner artist;

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(tokens.radii.card),
        child: Responsive(
          builder: (context, breakpoint) {
            final photo = SizedBox(
              height: breakpoint == AppBreakpoint.mobile
                  ? tokens.metrics.headlinerPhotoHeight
                  : null,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AssetCover(asset: artist.image, alt: artist.imageAlt),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF141414), Color(0x00141414)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: StatusPill(
                        label: artist.badge,
                        tone: PillTone.gold,
                        icon: MuttaMark(
                          size: tokens.spacing.sm + tokens.spacing.xs,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
            final copy = Padding(
              padding: EdgeInsets.all(tokens.spacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        muttaIcon('schedule'),
                        color: colors.primary,
                        size: tokens.metrics.iconMd,
                      ),
                      SizedBox(width: tokens.spacing.xs),
                      Flexible(
                        child: BrandText(
                          artist.time,
                          role: BrandRole.labelMd,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.sm),
                  BrandText(artist.name, role: BrandRole.headlineLg),
                  BrandText(artist.tags, role: BrandRole.labelSm),
                  SizedBox(height: tokens.spacing.sm),
                  BrandText(
                    artist.bio,
                    role: BrandRole.bodySm,
                    color: colors.onSurfaceVariant,
                  ),
                  SizedBox(height: tokens.spacing.md),
                  _Preview(artist: artist),
                ],
              ),
            );
            if (breakpoint == AppBreakpoint.mobile) {
              return Column(children: [photo, copy]);
            }
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: photo),
                  Expanded(child: copy),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Preview extends StatefulWidget {
  const new({required this.artist});

  final Headliner artist;

  @override
  State<_Preview> createState() => _PreviewState();
}

class _PreviewState extends State<_Preview> {
  var _playing = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final artist = widget.artist;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(tokens.radii.nested),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: BrandText(
                    artist.previewTitle,
                    role: BrandRole.labelSm,
                  ),
                ),
                BrandText(
                  artist.previewLive,
                  role: BrandRole.labelSm,
                  color: colors.primary,
                ),
              ],
            ),
            SizedBox(height: tokens.spacing.sm),
            Row(
              children: [
                Semantics(
                  button: true,
                  label: _playing ? 'Pausar muestra' : 'Reproducir muestra',
                  child: IconButton(
                    tooltip: _playing ? 'Pausar muestra' : 'Reproducir muestra',
                    onPressed: () => setState(() => _playing = !_playing),
                    style: IconButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                      fixedSize: Size.square(tokens.metrics.playButton),
                    ),
                    icon: Icon(muttaIcon(_playing ? 'pause' : 'play_arrow')),
                  ),
                ),
                SizedBox(width: tokens.spacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Wave(active: _playing),
                      SizedBox(height: tokens.spacing.xs),
                      BrandText(
                        artist.previewTrack,
                        role: BrandRole.labelSm,
                        color: colors.outline,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Wave extends StatelessWidget {
  const new({required this.active});

  final bool active;

  static const _heights = <double>[
    8,
    16,
    20,
    12,
    8,
    16,
    20,
    12,
    4,
    16,
    20,
    8,
    12,
    20,
    16,
    8,
    4,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: context.tokens.spacing.lg,
      child: Row(
        children: [
          for (final height in _heights)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: context.tokens.spacing.xs,
                height: active ? height : height * 0.45,
                decoration: BoxDecoration(
                  color: height > 12 ? colors.primary : colors.secondary,
                  borderRadius: BorderRadius.circular(
                    context.tokens.radii.full,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SupportColumn extends StatelessWidget {
  const new({
    required this.artists,
    required this.soundTitle,
    required this.soundBody,
    required this.onOpenProfile,
  });

  final List<SupportArtist> artists;
  final String soundTitle;
  final String soundBody;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Column(
      children: [
        for (final artist in artists) ...[
          _SupportCard(artist: artist, onOpenProfile: onOpenProfile),
          SizedBox(height: tokens.spacing.md),
        ],
        _SoundCard(title: soundTitle, body: soundBody),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  const new({required this.artist, required this.onOpenProfile});

  final SupportArtist artist;
  final VoidCallback onOpenProfile;

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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(tokens.radii.nested),
              child: SizedBox.square(
                dimension: tokens.metrics.artistThumb,
                child: AssetCover(asset: artist.image, alt: artist.imageAlt),
              ),
            ),
            SizedBox(width: tokens.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandText(
                    artist.time,
                    role: BrandRole.labelSm,
                    color: colors.primary,
                  ),
                  BrandText(artist.name, role: BrandRole.headlineSm),
                  BrandText(artist.style, role: BrandRole.bodySm),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Escuchar',
              onPressed: onOpenProfile,
              style: IconButton.styleFrom(
                backgroundColor: colors.surfaceContainer,
                foregroundColor: colors.onSurfaceVariant,
                fixedSize: Size.square(tokens.metrics.qtyButton),
              ),
              icon: Icon(muttaIcon('graphic_eq'), size: tokens.metrics.iconMd),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoundCard extends StatelessWidget {
  const new({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(tokens.radii.card),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: tokens.metrics.playButton,
                child: Icon(
                  muttaIcon('speaker'),
                  color: colors.primary,
                  size: tokens.metrics.iconMd,
                ),
              ),
            ),
            SizedBox(width: tokens.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandText(
                    title,
                    role: BrandRole.labelSm,
                    color: colors.onSurface,
                  ),
                  BrandText(body, role: BrandRole.bodySm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
