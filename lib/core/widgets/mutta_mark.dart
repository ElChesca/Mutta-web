import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

enum MuttaIsotipo {
  orange('assets/brand/isotipo-orange.webp'),
  onBlack('assets/brand/isotipo-black.webp'),
  onCream('assets/brand/isotipo-cream.webp');

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
    final image = Image.asset(
      variant.asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
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

  static const asset = 'assets/brand/wordmark-cream.webp';

  final double height;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      image: true,
      child: Image.asset(
        asset,
        height: height,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
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
