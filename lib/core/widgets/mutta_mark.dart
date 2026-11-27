import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

/// Isotipo provisorio. El archivo único es [asset].
class MuttaMark extends StatelessWidget {
  const new({required this.size, this.semanticLabel, super.key});

  static const asset = 'assets/brand/isotipo.svg';

  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final image = SvgPicture.asset(
      asset,
      width: size,
      height: size * 250 / 200,
      excludeFromSemantics: true,
    );
    final label = semanticLabel;
    if (label == null) {
      return ExcludeSemantics(child: image);
    }
    return Semantics(label: label, image: true, child: image);
  }
}

/// Wordmark en Montserrat Black. La Ö sale de la fuente, no de un trazo.
class MuttaWordmark extends StatelessWidget {
  const new({
    required this.text,
    required this.fontSize,
    this.color,
    super.key,
  });

  final String text;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        height: 0.9,
        letterSpacing: fontSize * -0.02,
        color: color ?? context.colors.onSurface,
      ),
    );
  }
}
