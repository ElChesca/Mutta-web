import 'package:flutter/material.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

class QuantitySelector extends StatelessWidget {
  const new({
    required this.quantity,
    required this.onChanged,
    this.minQuantity = 1,
    this.maxQuantity = 10,
    super.key,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int minQuantity;
  final int maxQuantity;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final canDecrease = quantity > minQuantity;
    final canIncrease = quantity < maxQuantity;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(tokens.radii.pill),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.sm,
          vertical: tokens.spacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepButton(
              tooltip: 'Quitar pase',
              icon: muttaIcon('remove'),
              enabled: canDecrease,
              onPressed: () => onChanged(quantity - 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: tokens.spacing.xs),
              child: Text('$quantity', style: context.texts.headlineSmall),
            ),
            _StepButton(
              tooltip: 'Agregar pase',
              icon: muttaIcon('add'),
              enabled: canIncrease,
              onPressed: () => onChanged(quantity + 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const new({
    required this.tooltip,
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return IconButton(
      tooltip: tooltip,
      onPressed: enabled ? onPressed : null,
      style: IconButton.styleFrom(
        backgroundColor: colors.surfaceContainer,
        foregroundColor: colors.onSurface,
        disabledForegroundColor: colors.onSurfaceVariant.withValues(alpha: 0.4),
        minimumSize: Size.square(tokens.metrics.qtyButton),
        fixedSize: Size.square(tokens.metrics.qtyButton),
        shape: const CircleBorder(),
      ),
      icon: Icon(icon, size: tokens.metrics.iconMd),
    );
  }
}
