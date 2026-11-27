import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';

class ClosingBand extends StatelessWidget {
  const new({
    required this.title,
    required this.cta,
    required this.onTickets,
    super.key,
  });

  final String title;
  final String cta;
  final VoidCallback onTickets;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final viewport = context.viewport;
    final base = tokens.surfaceBase;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            base,
            tokens.surfaceSubtle,
            tokens.accent.withValues(alpha: 0.45),
            base,
          ],
        ),
      ),
      child: ContentFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: viewport.sectionPadding),
          child: Column(
            children: [
              BrandText(
                title,
                role: viewport.compact
                    ? BrandRole.headlineMd
                    : BrandRole.headlineLg,
                heading: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: tokens.spacing.lg),
              MuttaButton(label: cta, onPressed: onTickets),
            ],
          ),
        ),
      ),
    );
  }
}
