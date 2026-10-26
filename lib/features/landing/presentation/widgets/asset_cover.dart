import 'package:flutter/widgets.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

class AssetCover extends StatelessWidget {
  const new({
    required this.asset,
    required this.alt,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String asset;
  final String alt;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: alt,
      image: true,
      child: Image.asset(
        asset,
        fit: fit,
        excludeFromSemantics: true,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          return ColoredBox(color: context.colors.surfaceContainer);
        },
      ),
    );
  }
}
