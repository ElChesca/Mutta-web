import 'package:material_ui/material_ui.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/data/models/event_content.dart';

class LineupSection extends StatelessWidget {
  const new({required this.lineup, super.key});

  final LineupContent lineup;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final viewport = context.viewport;
    final artists = [
      for (final artist in lineup.support)
        _Artist(
          time: artist.time,
          name: artist.name,
          detail: artist.style,
        ),
      _Artist(
        time: lineup.headliner.time,
        name: lineup.headliner.name,
        detail: lineup.headliner.tags,
        badge: lineup.headliner.badge,
      ),
    ];
    return ContentFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: viewport.sectionPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              eyebrow: lineup.eyebrow,
              title: lineup.title,
              subtitle: lineup.intro.isEmpty ? null : lineup.intro,
            ),
            SizedBox(height: viewport.headingGap),
            for (var i = 0; i < artists.length; i++) ...[
              if (i > 0)
                Divider(
                  height: tokens.spacing.xxl,
                  thickness: 1,
                  color: tokens.borderGhost,
                ),
              artists[i],
            ],
          ],
        ),
      ),
    );
  }
}

class _Artist extends StatelessWidget {
  const new({
    required this.time,
    required this.name,
    required this.detail,
    this.badge,
  });

  final String time;
  final String name;
  final String detail;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final compact = context.viewport.compact;
    final nameStyle = compact ? BrandRole.headlineSm : BrandRole.headlineMd;
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText(name, role: nameStyle),
        if (detail.isNotEmpty) ...[
          SizedBox(height: tokens.spacing.xs),
          BrandText(
            detail,
            role: BrandRole.bodySm,
            color: context.colors.onSurfaceVariant,
          ),
        ],
      ],
    );
    final when = BrandText(
      time,
      role: BrandRole.labelMd,
      color: context.colors.onSurfaceVariant,
    );
    final mark = badge;
    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          when,
          SizedBox(height: tokens.spacing.sm),
          copy,
          if (mark != null && mark.isNotEmpty) ...[
            SizedBox(height: tokens.spacing.sm),
            BrandText(
              mark,
              role: BrandRole.labelMd,
              color: context.colors.primary,
            ),
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 180, child: when),
        Expanded(child: copy),
        if (mark != null && mark.isNotEmpty)
          BrandText(
            mark,
            role: BrandRole.labelMd,
            color: context.colors.primary,
          ),
      ],
    );
  }
}
