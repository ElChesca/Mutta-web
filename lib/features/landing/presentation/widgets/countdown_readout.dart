import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/features/landing/logic/countdown.dart';

class CountdownPanel extends ConsumerWidget {
  const new({required this.label, required this.units, super.key});

  final String label;
  final List<String> units;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(countdownProvider);
    return CountdownReadout(value: value, label: label, units: units);
  }
}

class CountdownReadout extends StatelessWidget {
  const new({
    required this.value,
    required this.label,
    required this.units,
    super.key,
  });

  final CountdownValue value;
  final String label;
  final List<String> units;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final parts = [
      value.pad(value.days),
      value.pad(value.hours),
      value.pad(value.minutes),
      value.pad(value.seconds),
    ];
    final goldIndexes = {0, 3};
    final countdown = Semantics(
      label: value.spoken,
      child: ExcludeSemantics(
        child: context.viewport.compact
            ? _CompactReadout(label: label, parts: parts, units: units)
            : Column(
                children: [
                  if (label.isNotEmpty) ...[
                    BrandText(
                      label,
                      role: BrandRole.labelSm,
                      color: context.colors.onSurfaceVariant,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: tokens.spacing.sm),
                  ],
                  Row(
                    children: [
                      for (var index = 0; index < parts.length; index++) ...[
                        if (index > 0) SizedBox(width: tokens.spacing.sm),
                        Expanded(
                          child: _Cell(
                            value: parts[index],
                            unit: units[index],
                            gold: goldIndexes.contains(index),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
      ),
    );
    return countdown;
  }
}

class _CompactReadout extends StatelessWidget {
  const new({required this.label, required this.parts, required this.units});

  final String label;
  final List<String> parts;
  final List<String> units;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final figure = context.viewport.countdownFigure;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label.isNotEmpty) ...[
          BrandText(
            label,
            role: BrandRole.labelSm,
            color: colors.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: tokens.spacing.sm),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var index = 0; index < parts.length; index++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index > 0)
                    Padding(
                      padding: EdgeInsets.only(right: tokens.spacing.sm),
                      child: Text(
                        ':',
                        style: context.texts.labelSmall?.copyWith(
                          color: colors.outline,
                        ),
                      ),
                    ),
                  Column(
                    children: [
                      Text(parts[index], style: figure),
                      BrandText(units[index], role: BrandRole.labelSm),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const new({required this.value, required this.unit, required this.gold});

  final String value;
  final String unit;
  final bool gold;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: tokens.spacing.sm),
      child: Column(
        children: [
          Text(
            value,
            style: context.texts.headlineMedium?.copyWith(
              color: gold ? colors.primary : colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: tokens.spacing.xs),
          BrandText(
            unit,
            role: BrandRole.labelSm,
            color: colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
