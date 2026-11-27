import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/core/widgets/text_runs_view.dart';
import 'package:mutta_web/data/models/event_content.dart';

class LocationSection extends StatelessWidget {
  const new({
    required this.location,
    required this.onOpenMap,
    super.key,
  });

  final LocationContent location;
  final VoidCallback onOpenMap;

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
            SectionHeading(eyebrow: location.eyebrow, title: location.title),
            SizedBox(height: tokens.spacing.md),
            TextRunsView(location.body, role: context.texts.bodyLarge),
            SizedBox(height: tokens.spacing.lg),
            MuttaButton(
              label: location.mapCta,
              variant: MuttaButtonVariant.secondary,
              onPressed: onOpenMap,
            ),
          ],
        ),
      ),
    );
  }
}
