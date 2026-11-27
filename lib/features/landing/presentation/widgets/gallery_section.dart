import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/presentation/widgets/asset_cover.dart';

class GallerySection extends StatelessWidget {
  const new({required this.gallery, super.key});

  final GalleryContent gallery;

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
            SectionHeading(eyebrow: '', title: gallery.title),
            SizedBox(height: viewport.headingGap),
            Responsive(
              builder: (context, breakpoint) {
                final photos = [
                  for (final image in gallery.images)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(tokens.radii.nested),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: AssetCover(
                          asset: image.image,
                          alt: image.imageAlt,
                        ),
                      ),
                    ),
                ];
                if (breakpoint != AppBreakpoint.desktop) {
                  return Column(
                    children: [
                      for (var i = 0; i < photos.length; i++) ...[
                        if (i > 0) SizedBox(height: tokens.spacing.md),
                        photos[i],
                      ],
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < photos.length; i++) ...[
                      if (i > 0) SizedBox(width: tokens.spacing.md),
                      Expanded(child: photos[i]),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
