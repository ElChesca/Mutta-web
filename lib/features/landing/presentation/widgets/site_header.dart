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
              height: context.viewport.metrics.headerHeight,
              child: ContentFrame(
                child: Responsive(
                  builder: (context, breakpoint) {
                    if (breakpoint == AppBreakpoint.mobile) {
                      return _MobileHeaderBar(
                        label: chrome.brand,
                        profileImage: chrome.profileImage,
                        profileAlt: chrome.profileAlt,
                        onHome: () => onNavigate('hero'),
                      );
                    }
                    final showNav = breakpoint == AppBreakpoint.desktop;
                    return Row(
                      children: [
                        _Brand(
                          label: chrome.brand,
                          height: showNav
                              ? tokens.metrics.wordmarkHeight
                              : tokens.metrics.iconLg,
                          onTap: () => onNavigate('hero'),
                        ),
                        if (showNav)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: tokens.spacing.xl),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final item in navigation) ...[
                                      _NavLink(
                                        label: item.label,
                                        onTap: () => onNavigate(item.section),
                                      ),
                                      SizedBox(width: tokens.spacing.lg),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
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

class _MobileHeaderBar extends StatelessWidget {
  const new({
    required this.label,
    required this.profileImage,
    required this.profileAlt,
    required this.onHome,
  });

  final String label;
  final String profileImage;
  final String profileAlt;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final viewport = context.viewport;
    return Row(
      children: [
        Semantics(
          button: true,
          label: label,
          child: InkWell(
            onTap: onHome,
            borderRadius: BorderRadius.circular(tokens.radii.nested),
            child: ExcludeSemantics(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MuttaMark(size: tokens.metrics.logoBox),
                  SizedBox(width: tokens.spacing.sm),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(dimension: tokens.metrics.pulse),
                  ),
                  SizedBox(width: tokens.spacing.sm),
                  MuttaWordmark(height: viewport.metrics.wordmarkHeight),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        MuttaMark(size: viewport.metrics.coin),
        SizedBox(width: tokens.spacing.sm),
        ClipOval(
          child: SizedBox.square(
            dimension: tokens.metrics.avatar,
            child: AssetCover(asset: profileImage, alt: profileAlt),
          ),
        ),
      ],
    );
  }
}

class _NavTab {
  const new(this.section, this.label, this.icon);

  final String section;
  final String label;
  final String icon;
}

const _mobileTabs = <_NavTab>[
  _NavTab('hero', 'Sunset', 'wb_twilight'),
  _NavTab('lineup', 'Lineup', 'graphic_eq'),
  _NavTab('location', 'Potrero', 'near_me'),
];

class MobileChrome extends StatelessWidget {
  const new({
    required this.cta,
    required this.selected,
    required this.onBuy,
    required this.onSelect,
    super.key,
  });

  final String cta;
  final String selected;
  final VoidCallback onBuy;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final viewport = context.viewport;
    final safe = MediaQuery.paddingOf(context).bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing.margin,
            0,
            tokens.spacing.margin,
            tokens.spacing.sm,
          ),
          child: MuttaButton(
            label: cta,
            icon: muttaIcon('confirmation_number'),
            expand: true,
            onPressed: onBuy,
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: viewport.metrics.glassBlur,
              sigmaY: viewport.metrics.glassBlur,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: tokens.glass,
                border: Border(top: BorderSide(color: tokens.headerBorder)),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: safe),
                child: SizedBox(
                  height: viewport.bottomNavHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (final tab in _mobileTabs)
                        _TabButton(
                          tab: tab,
                          selected: selected == tab.section,
                          onTap: () => onSelect(tab.section),
                          color: selected == tab.section
                              ? colors.primary
                              : colors.onSurfaceVariant,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const new({
    required this.tab,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  final _NavTab tab;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: tab.label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.tokens.spacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                muttaIcon(tab.icon),
                color: color,
                size: context.viewport.metrics.iconLg,
              ),
              SizedBox(height: context.tokens.spacing.xs),
              BrandText(tab.label, role: BrandRole.labelSm, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const new({required this.label, required this.height, required this.onTap});

  final String label;
  final double height;
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
          MuttaWordmark(height: height, semanticLabel: label),
          SizedBox(width: tokens.spacing.sm),
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
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: context.tokens.spacing.xs,
            vertical: context.tokens.spacing.sm,
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(context.tokens.spacing.xs, context.viewport.metrics.touchMin),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
