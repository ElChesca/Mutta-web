import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/core/widgets/status_pill.dart';
import 'package:mutta_web/core/widgets/text_runs_view.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/logic/faq_controller.dart';
import 'package:mutta_web/features/landing/presentation/widgets/asset_cover.dart';
import 'package:mutta_web/features/landing/presentation/widgets/faq_tile.dart';

class LocationSection extends ConsumerWidget {
  const new({
    required this.location,
    required this.faq,
    required this.faqKey,
    required this.onOpenMap,
    required this.onSupport,
    super.key,
  });

  final LocationContent location;
  final FaqContent faq;
  final GlobalKey faqKey;
  final VoidCallback onOpenMap;
  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final viewport = context.viewport;
    final expanded = ref.watch(faqProvider);
    return ContentFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: viewport.compact
              ? viewport.sectionPadding
              : tokens.spacing.xxl,
        ),
        child: Responsive(
          builder: (context, breakpoint) {
            final place = _PlaceColumn(
              location: location,
              onOpenMap: onOpenMap,
            );
            final questions = KeyedSubtree(
              key: faqKey,
              child: _FaqColumn(
                faq: faq,
                expanded: expanded,
                onToggle: (id) => ref.read(faqProvider.notifier).toggle(id),
                onSupport: onSupport,
              ),
            );
            if (breakpoint != AppBreakpoint.desktop) {
              return Column(
                children: [
                  place,
                  SizedBox(
                    height: breakpoint == AppBreakpoint.mobile
                        ? viewport.sectionPadding
                        : tokens.spacing.xxl,
                  ),
                  questions,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: place),
                SizedBox(width: tokens.spacing.gutterDesktop),
                Expanded(flex: 5, child: questions),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PlaceColumn extends StatelessWidget {
  const new({required this.location, required this.onOpenMap});

  final LocationContent location;
  final VoidCallback onOpenMap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(eyebrow: location.eyebrow, title: location.title),
        SizedBox(height: tokens.spacing.xs),
        TextRunsView(
          location.body,
          role: context.texts.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        SizedBox(
          height: context.viewport.compact
              ? context.viewport.headingGap
              : tokens.spacing.lg,
        ),
        if (context.viewport.compact)
          _CompactMap(location: location, onOpenMap: onOpenMap)
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(tokens.radii.card),
            child: SizedBox(
              height: tokens.metrics.mapHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AssetCover(asset: location.mapImage, alt: location.mapAlt),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x000E0E0E), Color(0xE60E0E0E)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLowest.withValues(
                            alpha: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(
                            tokens.radii.nested,
                          ),
                          border: Border.all(
                            color: colors.outlineVariant.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(tokens.spacing.md),
                          child: Row(
                            children: [
                              Icon(
                                muttaIcon('pin_drop'),
                                color: colors.primary,
                              ),
                              SizedBox(width: tokens.spacing.sm),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BrandText(
                                      location.mapTitle,
                                      role: BrandRole.labelMd,
                                    ),
                                    BrandText(
                                      location.mapSubtitle,
                                      role: BrandRole.bodySm,
                                      color: colors.secondary,
                                    ),
                                  ],
                                ),
                              ),
                              MuttaButton(
                                label: location.mapCta,
                                onPressed: onOpenMap,
                                padding: EdgeInsets.symmetric(
                                  horizontal: tokens.spacing.md,
                                  vertical: tokens.spacing.xs,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: tokens.spacing.md),
        Responsive(
          builder: (context, breakpoint) {
            final notes = [
              for (final note in location.notes) _NoteCard(note: note),
            ];
            if (breakpoint == AppBreakpoint.mobile) {
              return Column(
                children: [
                  for (final note in notes) ...[
                    note,
                    SizedBox(height: context.viewport.stackGap),
                  ],
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: notes.first),
                SizedBox(width: tokens.spacing.md),
                Expanded(child: notes.last),
              ],
            );
          },
        ),
        SizedBox(height: tokens.spacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(tokens.radii.card),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Icon(muttaIcon('checkroom'), color: colors.primary),
                SizedBox(width: tokens.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandText(
                        location.dressLabel,
                        role: BrandRole.labelSm,
                        color: colors.secondary,
                      ),
                      BrandText(
                        location.dressTitle,
                        role: BrandRole.headlineSm,
                      ),
                    ],
                  ),
                ),
                StatusPill(label: location.dressChip),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactMap extends StatelessWidget {
  const new({required this.location, required this.onOpenMap});

  final LocationContent location;
  final VoidCallback onOpenMap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final viewport = context.viewport;
    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.radii.card),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(tokens.radii.card),
        ),
        child: Column(
          children: [
            SizedBox(
              height: viewport.metrics.mapHeight,
              width: double.infinity,
              child: AssetCover(asset: location.mapImage, alt: location.mapAlt),
            ),
            ColoredBox(
              color: colors.surfaceContainerHigh,
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
                        dimension: viewport.metrics.playButton,
                        child: Icon(
                          muttaIcon('explore'),
                          color: colors.primary,
                          size: viewport.metrics.iconMd,
                        ),
                      ),
                    ),
                    SizedBox(width: tokens.spacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BrandText(location.mapTitle, role: BrandRole.labelMd),
                          BrandText(
                            location.mapSubtitle,
                            role: BrandRole.bodySm,
                            color: colors.secondary,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: tokens.spacing.sm),
                    MuttaButton(
                      label: location.mapCta,
                      onPressed: onOpenMap,
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.spacing.md,
                        vertical: tokens.spacing.xs,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const new({required this.note});

  final InfoNote note;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final compact = context.viewport.compact;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(tokens.radii.card),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: compact
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    muttaIcon(note.icon),
                    color: colors.primary,
                    size: tokens.metrics.iconLg,
                  ),
                  SizedBox(width: context.viewport.stackGap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BrandText(note.title, role: BrandRole.headlineSm),
                        SizedBox(height: tokens.spacing.xs),
                        BrandText(
                          note.body,
                          role: BrandRole.bodySm,
                          color: colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        muttaIcon(note.icon),
                        color: colors.primary,
                        size: tokens.metrics.iconMd,
                      ),
                      SizedBox(width: tokens.spacing.xs),
                      Flexible(
                        child: BrandText(
                          note.title,
                          role: BrandRole.labelSm,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacing.xs),
                  BrandText(
                    note.body,
                    role: BrandRole.bodySm,
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ),
      ),
    );
  }
}

class _FaqColumn extends StatelessWidget {
  const new({
    required this.faq,
    required this.expanded,
    required this.onToggle,
    required this.onSupport,
  });

  final FaqContent faq;
  final Set<String> expanded;
  final ValueChanged<String> onToggle;
  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(eyebrow: faq.eyebrow, title: faq.title),
        SizedBox(height: tokens.spacing.md),
        for (final item in faq.items) ...[
          FaqTile(
            item: item,
            expanded: expanded.contains(item.id),
            onToggle: () => onToggle(item.id),
          ),
          SizedBox(
            height: context.viewport.compact
                ? context.viewport.stackGap
                : tokens.spacing.md,
          ),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(tokens.radii.card),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandText(
                        faq.supportTitle,
                        role: BrandRole.labelSm,
                        color: colors.onSurface,
                      ),
                      BrandText(faq.supportBody, role: BrandRole.bodySm),
                    ],
                  ),
                ),
                MuttaButton(
                  label: faq.supportCta,
                  variant: MuttaButtonVariant.tonal,
                  onPressed: onSupport,
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.md,
                    vertical: tokens.spacing.xs,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
