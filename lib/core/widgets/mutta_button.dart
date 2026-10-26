import 'package:flutter/material.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';

enum MuttaButtonVariant { primary, secondary, tonal, ghost }

class MuttaButton extends StatelessWidget {
  const new({
    required this.label,
    required this.onPressed,
    this.variant = MuttaButtonVariant.primary,
    this.icon,
    this.trailingIcon,
    this.expand = false,
    this.padding,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final MuttaButtonVariant variant;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool expand;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final spacing = tokens.spacing;
    final metrics = context.viewport.metrics;
    final resolvedPadding =
        padding ??
        EdgeInsets.symmetric(horizontal: spacing.lg, vertical: spacing.sm);

    final background = switch (variant) {
      MuttaButtonVariant.primary => colors.primary,
      MuttaButtonVariant.secondary => Colors.transparent,
      MuttaButtonVariant.tonal => colors.surfaceContainerHigh,
      MuttaButtonVariant.ghost => Colors.transparent,
    };
    final foreground = switch (variant) {
      MuttaButtonVariant.primary => colors.onPrimary,
      MuttaButtonVariant.secondary => colors.onSurface,
      MuttaButtonVariant.tonal => colors.onSurface,
      MuttaButtonVariant.ghost => colors.onSurfaceVariant,
    };
    final hoverForeground = switch (variant) {
      MuttaButtonVariant.ghost => colors.primary,
      _ => foreground,
    };
    final hoverBackground = switch (variant) {
      MuttaButtonVariant.primary => Color.lerp(
        colors.primary,
        colors.onSurface,
        0.08,
      ),
      MuttaButtonVariant.secondary => tokens.sandHover,
      MuttaButtonVariant.tonal => colors.surfaceContainerHighest,
      MuttaButtonVariant.ghost => Colors.transparent,
    };

    final button = TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(
          Size(metrics.touchMin, metrics.touchMin),
        ),
        padding: WidgetStatePropertyAll(resolvedPadding),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return background.withValues(alpha: 0.38);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return hoverBackground;
          }
          return background;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return foreground.withValues(alpha: 0.45);
          }
          if (states.contains(WidgetState.hovered)) {
            return hoverForeground;
          }
          return foreground;
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (variant == MuttaButtonVariant.primary &&
              states.contains(WidgetState.hovered) &&
              !states.contains(WidgetState.disabled)) {
            return 8;
          }
          return 0;
        }),
        shadowColor: WidgetStatePropertyAll(tokens.buttonGlow.first.color),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radii.pill),
          ),
        ),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: colors.primary, width: 1.5);
          }
          if (variant == MuttaButtonVariant.secondary) {
            return BorderSide(color: colors.onSurface, width: 1.5);
          }
          return BorderSide.none;
        }),
        textStyle: WidgetStatePropertyAll(context.texts.labelLarge),
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: metrics.iconMd),
            SizedBox(width: spacing.sm),
          ],
          Flexible(
            child: Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailingIcon != null) ...[
            SizedBox(width: spacing.sm),
            Icon(trailingIcon, size: metrics.iconMd),
          ],
        ],
      ),
    );

    if (!expand) {
      return button;
    }
    return SizedBox(width: double.infinity, child: button);
  }
}
