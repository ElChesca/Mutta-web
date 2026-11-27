import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/logic/mobile_menu.dart';

class SiteHeader extends ConsumerWidget {
  const new({
    required this.chrome,
    required this.navigation,
    required this.onNavigate,
    required this.onBuy,
    super.key,
  });

  final ChromeContent chrome;
  final List<NavItem> navigation;
  final ValueChanged<String> onNavigate;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final open = ref.watch(mobileMenuProvider);
    final breakpoint = AppLayout.of(context);
    final desktop = breakpoint == AppBreakpoint.desktop;
    return Semantics(
      header: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tokens.surfaceBase,
          border: Border(bottom: BorderSide(color: tokens.headerBorder)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: context.viewport.metrics.headerHeight,
              child: ContentFrame(
                child: Row(
                  children: [
                    _BrandLockup(
                      label: chrome.brand,
                      mark: desktop ? 28 : 24,
                      wordmark: context.viewport.metrics.wordmarkHeight,
                      onTap: () => onNavigate('hero'),
                    ),
                    const Spacer(),
                    if (desktop)
                      for (final item in navigation) ...[
                        _NavLink(
                          label: item.label,
                          onTap: () => onNavigate(item.section),
                        ),
                        SizedBox(width: tokens.spacing.md),
                      ],
                    if (desktop)
                      MuttaButton(label: chrome.buyLabel, onPressed: onBuy)
                    else
                      IconButton(
                        tooltip: open
                            ? chrome.closeMenuLabel
                            : chrome.openMenuLabel,
                        onPressed: ref
                            .read(mobileMenuProvider.notifier)
                            .toggle,
                        icon: Icon(
                          muttaIcon(open ? 'close' : 'menu'),
                          color: context.colors.onSurface,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (open && !desktop)
              ContentFrame(
                child: Padding(
                  padding: EdgeInsets.only(bottom: tokens.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final item in navigation)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              ref.read(mobileMenuProvider.notifier).close();
                              onNavigate(item.section);
                            },
                            child: BrandText(
                              item.label,
                              role: BrandRole.labelLg,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const new({
    required this.label,
    required this.mark,
    required this.wordmark,
    required this.onTap,
  });

  final String label;
  final double mark;
  final double wordmark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tokens.radii.nested),
        child: ExcludeSemantics(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MuttaMark(size: mark),
              SizedBox(width: tokens.spacing.sm),
              MuttaWordmark(text: label, fontSize: wordmark),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const new({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: BrandText(
        label,
        role: BrandRole.labelMd,
        color: context.colors.onSurfaceVariant,
      ),
    );
  }
}

class MobileChrome extends StatelessWidget {
  const new({required this.cta, required this.onBuy, super.key});

  final String cta;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final safe = MediaQuery.paddingOf(context).bottom;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.surfaceBase,
        border: Border(top: BorderSide(color: tokens.headerBorder)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          tokens.spacing.margin,
          tokens.spacing.sm,
          tokens.spacing.margin,
          tokens.spacing.sm + safe,
        ),
        child: MuttaButton(label: cta, expand: true, onPressed: onBuy),
      ),
    );
  }
}
