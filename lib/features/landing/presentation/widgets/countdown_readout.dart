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
    return Semantics(
      label: value.spoken,
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandText(
              label,
              role: BrandRole.labelSm,
              color: context.colors.outline,
            ),
            SizedBox(height: tokens.spacing.sm),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(tokens.radii.nested),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.sm),
        child: Column(
          children: [
            Text(
              value,
              style: context.texts.headlineLarge?.copyWith(
                color: gold ? colors.primary : colors.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: tokens.spacing.xs),
            BrandText(unit, role: BrandRole.labelSm),
          ],
        ),
      ),
    );
  }
}
