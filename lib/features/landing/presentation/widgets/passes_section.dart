import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/core/widgets/section_heading.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/logic/ticket_selection.dart';
import 'package:mutta_web/features/landing/presentation/widgets/checkout_bar.dart';
import 'package:mutta_web/features/landing/presentation/widgets/pass_card.dart';

class PassesSection extends ConsumerWidget {
  const new({
    required this.passes,
    required this.onPay,
    required this.checkoutKey,
    super.key,
  });

  final PassesContent passes;
  final VoidCallback onPay;
  final GlobalKey checkoutKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    return ColoredBox(
      color: tokens.surfaceSection,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.025,
                child: Center(
                  child: MuttaMark(
                    color: context.colors.primary,
                    size: tokens.metrics.watermark,
                  ),
                ),
              ),
            ),
          ),
          ContentFrame(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: tokens.spacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Responsive(
                    builder: (context, breakpoint) {
                      final heading = SectionHeading(
                        eyebrow: passes.eyebrow,
                        title: passes.title,
                      );
                      final intro = ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: BrandText(
                          passes.intro,
                          role: BrandRole.bodyMd,
                          color: context.colors.onSurfaceVariant,
                        ),
                      );
                      if (breakpoint == AppBreakpoint.mobile) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading,
                            SizedBox(height: tokens.spacing.md),
                            intro,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: heading),
                          SizedBox(width: tokens.spacing.lg),
                          Expanded(child: intro),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: tokens.spacing.xxl),
                  Responsive(
                    builder: (context, breakpoint) {
                      final cards = [
                        for (final tier in passes.tiers)
                          PassCard(
                            tier: tier,
                            onSelect: () {
                              ref
                                  .read(ticketSelectionProvider.notifier)
                                  .select(tier);
                            },
                          ),
                      ];
                      if (breakpoint != AppBreakpoint.desktop) {
                        return Column(
                          children: [
                            for (final card in cards) ...[
                              card,
                              SizedBox(height: tokens.spacing.gutterDesktop),
                            ],
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < cards.length; i++) ...[
                            if (i > 0)
                              SizedBox(width: tokens.spacing.gutterDesktop),
                            Expanded(child: cards[i]),
                          ],
                        ],
                      );
                    },
                  ),
                  SizedBox(height: tokens.spacing.xl),
                  KeyedSubtree(
                    key: checkoutKey,
                    child: CheckoutPanel(copy: passes.checkout, onPay: onPay),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
