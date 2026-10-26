import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/format/ars_money.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/logic/ticket_selection.dart';
import 'package:mutta_web/features/landing/presentation/widgets/quantity_selector.dart';

class CheckoutPanel extends ConsumerWidget {
  const new({required this.copy, required this.onPay, super.key});

  final CheckoutCopy copy;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(ticketSelectionProvider);
    return CheckoutBar(
      selectionLabel: copy.selectionLabel,
      totalLabel: copy.totalLabel,
      payLabel: copy.payLabel,
      name: selection.name,
      description: selection.description,
      quantity: selection.quantity,
      minQuantity: selection.minQuantity,
      maxQuantity: selection.maxQuantity,
      totalLabelValue: formatArsTotal(selection.total),
      onQuantityChanged: ref.read(ticketSelectionProvider.notifier).setQuantity,
      onPay: onPay,
    );
  }
}

class CheckoutBar extends StatelessWidget {
  const new({
    required this.selectionLabel,
    required this.totalLabel,
    required this.payLabel,
    required this.name,
    required this.description,
    required this.quantity,
    required this.minQuantity,
    required this.maxQuantity,
    required this.totalLabelValue,
    required this.onQuantityChanged,
    required this.onPay,
    super.key,
  });

  final String selectionLabel;
  final String totalLabel;
  final String payLabel;
  final String name;
  final String description;
  final int quantity;
  final int minQuantity;
  final int maxQuantity;
  final String totalLabelValue;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Responsive(
      builder: (context, breakpoint) {
        final stacked = breakpoint == AppBreakpoint.mobile;
        final summary = _Summary(
          quantity: quantity,
          selectionLabel: selectionLabel,
          name: name,
          description: description,
        );
        final actions = Wrap(
          spacing: tokens.spacing.lg,
          runSpacing: tokens.spacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            QuantitySelector(
              quantity: quantity,
              minQuantity: minQuantity,
              maxQuantity: maxQuantity,
              onChanged: onQuantityChanged,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BrandText(totalLabel, role: BrandRole.labelSm),
                Text(
                  totalLabelValue,
                  style: context.texts.headlineMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            MuttaButton(
              label: payLabel,
              onPressed: onPay,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.lg,
                vertical: tokens.spacing.sm,
              ),
            ),
          ],
        );
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(tokens.radii.card),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(tokens.spacing.lg),
            child: stacked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      summary,
                      SizedBox(height: tokens.spacing.md),
                      actions,
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: summary),
                      actions,
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _Summary extends StatelessWidget {
  const new({
    required this.quantity,
    required this.selectionLabel,
    required this.name,
    required this.description,
  });

  final int quantity;
  final String selectionLabel;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primary,
            shape: BoxShape.circle,
          ),
          child: SizedBox.square(
            dimension: tokens.metrics.coin,
            child: Center(
              child: Text(
                '$quantity',
                style: context.texts.headlineSmall?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: tokens.spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandText(selectionLabel, role: BrandRole.labelSm),
              BrandText(name, role: BrandRole.headlineSm),
              BrandText(
                description,
                role: BrandRole.bodySm,
                color: colors.secondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
