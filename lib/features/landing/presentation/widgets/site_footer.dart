import 'package:material_ui/material_ui.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/data/models/event_content.dart';

class SiteFooter extends StatelessWidget {
  const new({
    required this.footer,
    required this.onInstagram,
    super.key,
  });

  final FooterContent footer;
  final VoidCallback onInstagram;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: tokens.headerBorder)),
      ),
      child: ContentFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.viewport.sectionPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: tokens.spacing.lg,
                runSpacing: tokens.spacing.sm,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextButton(
                    onPressed: onInstagram,
                    child: BrandText(
                      'Instagram',
                      role: BrandRole.labelMd,
                      color: colors.onSurface,
                    ),
                  ),
                  BrandText(
                    footer.producers,
                    role: BrandRole.bodySm,
                    color: colors.onSurfaceVariant,
                  ),
                  BrandText(
                    footer.ageNote,
                    role: BrandRole.labelSm,
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(height: tokens.spacing.lg),
              Wrap(
                spacing: tokens.spacing.md,
                runSpacing: tokens.spacing.sm,
                children: [
                  for (final name in footer.sponsors)
                    BrandText(
                      name,
                      role: BrandRole.labelSm,
                      color: colors.onSurfaceVariant,
                    ),
                ],
              ),
              SizedBox(height: tokens.spacing.xl),
              BrandText(
                footer.legal,
                role: BrandRole.bodySm,
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
