import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

enum MuttaIsotipo {
  orange('assets/brand/isotipo-orange.svg'),
  onBlack('assets/brand/isotipo-black.svg'),
  onCream('assets/brand/isotipo-cream.svg');

  new(this.asset);

  final String asset;
}

class MuttaMark extends StatelessWidget {
  const new({
    required this.size,
    this.variant = MuttaIsotipo.orange,
    this.semanticLabel,
    super.key,
  });

  final double size;
  final MuttaIsotipo variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final image = SvgPicture.asset(
      variant.asset,
      width: size,
      height: size,
      excludeFromSemantics: true,
    );
    final label = semanticLabel;
    if (label == null) {
      return ExcludeSemantics(child: image);
    }
    return Semantics(label: label, image: true, child: image);
  }
}

class MuttaWordmark extends StatelessWidget {
  const new({required this.height, this.semanticLabel = 'MUTTA', super.key});

  static const asset = 'assets/brand/wordmark-cream.svg';

  final double height;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      image: true,
      child: SvgPicture.asset(
        asset,
        height: height,
        excludeFromSemantics: true,
      ),
    );
  }
}

class MuttaLockup extends StatelessWidget {
  const new({
    required this.height,
    required this.tagline,
    this.semanticLabel = 'MUTTA',
    super.key,
  });

  final double height;
  final String tagline;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      label: '$semanticLabel. $tagline',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MuttaWordmark(height: height, semanticLabel: semanticLabel),
            SizedBox(height: tokens.spacing.sm),
            Text(tagline, style: wordmarkTaglineStyle()),
          ],
        ),
      ),
    );
  }
}
