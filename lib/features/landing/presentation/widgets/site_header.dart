import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/logic/mobile_menu.dart';
import 'package:mutta_web/features/landing/presentation/widgets/asset_cover.dart';

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
    return Semantics(
      header: true,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: tokens.metrics.glassBlur,
            sigmaY: tokens.metrics.glassBlur,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tokens.glass,
              border: Border(bottom: BorderSide(color: tokens.headerBorder)),
              boxShadow: tokens.headerShadow,
            ),
            child: SizedBox(
              height: tokens.metrics.headerHeight,
              child: ContentFrame(
                child: Responsive(
                  builder: (context, breakpoint) {
                    final showNav = breakpoint == AppBreakpoint.desktop;
                    return Row(
                      children: [
                        _Brand(
                          label: chrome.brand,
                          onTap: () => onNavigate('hero'),
                        ),
                        if (showNav) ...[
                          SizedBox(width: tokens.spacing.xl),
                          for (final item in navigation) ...[
                            _NavLink(
                              label: item.label,
                              onTap: () => onNavigate(item.section),
                            ),
                            SizedBox(width: tokens.spacing.lg),
                          ],
                        ],
                        const Spacer(),
                        MuttaButton(label: chrome.buyLabel, onPressed: onBuy),
                        SizedBox(width: tokens.spacing.sm),
                        ClipOval(
                          child: SizedBox.square(
                            dimension: tokens.metrics.avatar,
                            child: AssetCover(
                              asset: chrome.profileImage,
                              alt: chrome.profileAlt,
                            ),
                          ),
                        ),
                        if (!showNav) ...[
                          SizedBox(width: tokens.spacing.xs),
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const new({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(tokens.radii.nested),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(tokens.radii.nested),
              border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
            ),
            child: SizedBox.square(
              dimension: tokens.metrics.logoBox,
              child: Padding(
                padding: EdgeInsets.all(tokens.spacing.xs),
                child: MuttaMark(
                  color: colors.primary,
                  size: tokens.metrics.iconLg,
                ),
              ),
            ),
          ),
          SizedBox(width: tokens.spacing.sm),
          BrandText(label, role: BrandRole.headlineMd),
          SizedBox(width: tokens.spacing.xs),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(dimension: tokens.metrics.pulse),
          ),
        ],
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
    final colors = context.colors;
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return colors.onSurface;
          }
          return colors.onSurfaceVariant;
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      child: BrandText(label, role: BrandRole.labelMd),
    );
  }
}

class MobileMenu extends StatelessWidget {
  const new({required this.navigation, required this.onNavigate, super.key});

  final List<NavItem> navigation;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Semantics(
      label: 'Menú',
      child: ColoredBox(
        color: tokens.glass,
        child: ContentFrame(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: tokens.spacing.lg),
            children: [
              for (final item in navigation)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: BrandText(item.label, role: BrandRole.labelLg),
                  onTap: () => onNavigate(item.section),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
