import 'package:flutter/widgets.dart';

class MuttaMark extends StatelessWidget {
  const new({
    required this.color,
    required this.size,
    this.semanticLabel,
    super.key,
  });

  final Color color;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final painter = CustomPaint(
      size: Size.square(size),
      painter: _MarkPainter(color),
    );
    final label = semanticLabel;
    if (label == null) {
      return ExcludeSemantics(
        child: SizedBox.square(dimension: size, child: painter),
      );
    }
    return Semantics(
      label: label,
      image: true,
      child: SizedBox.square(dimension: size, child: painter),
    );
  }
}

class _MarkPainter extends CustomPainter {
  const new(this.color);

  final Color color;

  static final Path _path = Path()
    ..moveTo(16, 82)
    ..lineTo(16, 18)
    ..lineTo(35, 18)
    ..lineTo(50, 56)
    ..lineTo(65, 18)
    ..lineTo(84, 18)
    ..lineTo(84, 82)
    ..lineTo(68, 82)
    ..lineTo(68, 40)
    ..lineTo(55, 72)
    ..lineTo(45, 72)
    ..lineTo(32, 40)
    ..lineTo(32, 82)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..scale(size.width / 100, size.height / 100)
      ..drawPath(_path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_MarkPainter oldDelegate) => oldDelegate.color != color;
}
