import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';

const _base = Color(0xFF0B0B0B);
const _accent = Color(0xFFFF8A37);
const _cream = Color(0xFFF6F2E7);
const _earth = Color(0xFFA7A097);
const _elevated = Color(0xFF141414);
const _subtle = Color(0xFF1F1E1D);
const _lowest = Color(0xFF0E0E0E);
const _panel = Color(0xFF201F1F);
const _high = Color(0xFF2A2A2A);
const _highest = Color(0xFF353534);
const _error = Color(0xFFFFB4AB);
const _onError = Color(0xFF690005);
const _errorContainer = Color(0xFF93000A);
const _onErrorContainer = Color(0xFFFFDAD6);
const _outlineVariant = Color(0xFF4E3824);
const _inverseSurface = Color(0xFFE5E2E1);
const _onInverseSurface = Color(0xFF313030);
const _inversePrimary = Color(0xFF8A3C12);
const Color _surfaceTint = _accent;

const _borderDim = Color.fromRGBO(167, 160, 151, 0.18);
const _borderGhost = Color.fromRGBO(167, 160, 151, 0.20);
const _borderCard = Color.fromRGBO(167, 160, 151, 0.16);
const _borderInput = Color.fromRGBO(167, 160, 151, 0.30);
const _glass = Color.fromRGBO(11, 11, 11, 0.78);
const _headerBorder = Color.fromRGBO(32, 31, 31, 0.60);
const _sandHover = Color.fromRGBO(246, 242, 231, 0.08);
const _accentSoft = Color.fromRGBO(255, 138, 55, 0.16);
const _accentButton = Color.fromRGBO(255, 138, 55, 0.25);
const _accentHalo = Color.fromRGBO(255, 138, 55, 0.12);
const _accentWash = Color.fromRGBO(255, 138, 55, 0.20);

class MuttaSpacing {
  const new({
    required this.xs,
    required this.tight,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.gutter,
    required this.gutterTablet,
    required this.gutterDesktop,
    required this.margin,
    required this.marginTablet,
    required this.marginDesktop,
  });

  final double xs;
  final double tight;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double gutter;
  final double gutterTablet;
  final double gutterDesktop;
  final double margin;
  final double marginTablet;
  final double marginDesktop;

  static const standard = MuttaSpacing(
    xs: 4,
    tight: 12,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 40,
    xxl: 64,
    gutter: 20,
    gutterTablet: 24,
    gutterDesktop: 32,
    margin: 20,
    marginTablet: 32,
    marginDesktop: 64,
  );

  MuttaSpacing lerp(MuttaSpacing other, double t) {
    return MuttaSpacing(
      xs: lerpDouble(xs, other.xs, t)!,
      tight: lerpDouble(tight, other.tight, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
      gutter: lerpDouble(gutter, other.gutter, t)!,
      gutterTablet: lerpDouble(gutterTablet, other.gutterTablet, t)!,
      gutterDesktop: lerpDouble(gutterDesktop, other.gutterDesktop, t)!,
      margin: lerpDouble(margin, other.margin, t)!,
      marginTablet: lerpDouble(marginTablet, other.marginTablet, t)!,
      marginDesktop: lerpDouble(marginDesktop, other.marginDesktop, t)!,
    );
  }
}

class MuttaRadii {
  const new({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.full,
  });

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double full;

  double get card => lg;
  double get nested => md;
  double get pill => full;

  static const standard = MuttaRadii(
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
    full: 999,
  );

  MuttaRadii lerp(MuttaRadii other, double t) {
    return MuttaRadii(
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
      full: lerpDouble(full, other.full, t)!,
    );
  }
}

class MuttaMetrics {
  const new({
    required this.headerHeight,
    required this.maxWidth,
    required this.posterAspect,
    required this.mapHeight,
    required this.headlinerPhotoHeight,
    required this.iconSm,
    required this.iconMd,
    required this.iconLg,
    required this.avatar,
    required this.logoBox,
    required this.wordmarkHeight,
    required this.wordmarkHero,
    required this.pulse,
    required this.artistThumb,
    required this.playButton,
    required this.qtyButton,
    required this.coin,
    required this.pillarIcon,
    required this.isotipo,
    required this.isotipoCompact,
    required this.watermark,
    required this.touchMin,
    required this.glassBlur,
  });

  final double headerHeight;
  final double maxWidth;
  final double posterAspect;
  final double mapHeight;
  final double headlinerPhotoHeight;
  final double iconSm;
  final double iconMd;
  final double iconLg;
  final double avatar;
  final double logoBox;
  final double wordmarkHeight;
  final double wordmarkHero;
  final double pulse;
  final double artistThumb;
  final double playButton;
  final double qtyButton;
  final double coin;
  final double pillarIcon;
  final double isotipo;
  final double isotipoCompact;
  final double watermark;
  final double touchMin;
  final double glassBlur;

  static const standard = MuttaMetrics(
    headerHeight: 80,
    maxWidth: 1320,
    posterAspect: 3 / 4.4,
    mapHeight: 320,
    headlinerPhotoHeight: 320,
    iconSm: 14,
    iconMd: 18,
    iconLg: 24,
    avatar: 32,
    logoBox: 32,
    wordmarkHeight: 28,
    wordmarkHero: 48,
    pulse: 6,
    artistThumb: 64,
    playButton: 40,
    qtyButton: 32,
    coin: 40,
    pillarIcon: 56,
    isotipo: 224,
    isotipoCompact: 192,
    watermark: 620,
    touchMin: 44,
    glassBlur: 16,
  );

  /// Escala del mockup móvil. Los campos que no cambian copian [standard].
  static const mobile = MuttaMetrics(
    headerHeight: 64,
    maxWidth: 1320,
    posterAspect: 3 / 4.4,
    mapHeight: 208,
    headlinerPhotoHeight: 320,
    iconSm: 14,
    iconMd: 18,
    iconLg: 24,
    avatar: 32,
    logoBox: 32,
    wordmarkHeight: 18,
    wordmarkHero: 36,
    pulse: 6,
    artistThumb: 44,
    playButton: 32,
    qtyButton: 32,
    coin: 28,
    pillarIcon: 56,
    isotipo: 224,
    isotipoCompact: 192,
    watermark: 620,
    touchMin: 48,
    glassBlur: 16,
  );

  MuttaMetrics lerp(MuttaMetrics other, double t) {
    return MuttaMetrics(
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t)!,
      maxWidth: lerpDouble(maxWidth, other.maxWidth, t)!,
      posterAspect: lerpDouble(posterAspect, other.posterAspect, t)!,
      mapHeight: lerpDouble(mapHeight, other.mapHeight, t)!,
      headlinerPhotoHeight: lerpDouble(
        headlinerPhotoHeight,
        other.headlinerPhotoHeight,
        t,
      )!,
      iconSm: lerpDouble(iconSm, other.iconSm, t)!,
      iconMd: lerpDouble(iconMd, other.iconMd, t)!,
      iconLg: lerpDouble(iconLg, other.iconLg, t)!,
      avatar: lerpDouble(avatar, other.avatar, t)!,
      logoBox: lerpDouble(logoBox, other.logoBox, t)!,
      wordmarkHeight: lerpDouble(wordmarkHeight, other.wordmarkHeight, t)!,
      wordmarkHero: lerpDouble(wordmarkHero, other.wordmarkHero, t)!,
      pulse: lerpDouble(pulse, other.pulse, t)!,
      artistThumb: lerpDouble(artistThumb, other.artistThumb, t)!,
      playButton: lerpDouble(playButton, other.playButton, t)!,
      qtyButton: lerpDouble(qtyButton, other.qtyButton, t)!,
      coin: lerpDouble(coin, other.coin, t)!,
      pillarIcon: lerpDouble(pillarIcon, other.pillarIcon, t)!,
      isotipo: lerpDouble(isotipo, other.isotipo, t)!,
      isotipoCompact: lerpDouble(isotipoCompact, other.isotipoCompact, t)!,
      watermark: lerpDouble(watermark, other.watermark, t)!,
      touchMin: lerpDouble(touchMin, other.touchMin, t)!,
      glassBlur: lerpDouble(glassBlur, other.glassBlur, t)!,
    );
  }
}

/// Decisiones de layout por breakpoint. El móvil sigue el mockup de Stitch;
/// tablet y desktop comparten [desktop] para no mover la landing cerrada.
class MuttaViewport {
  const new({
    required this.metrics,
    required this.heroHeight,
    required this.heroEmblem,
    required this.headlinerAvatar,
    required this.bottomNavHeight,
    required this.stickyCtaHeight,
    required this.bottomInset,
    required this.sectionPadding,
    required this.headingGap,
    required this.stackGap,
    required this.countdownFigure,
    required this.compact,
  });

  final MuttaMetrics metrics;
  final double heroHeight;
  final double heroEmblem;
  final double headlinerAvatar;
  final double bottomNavHeight;
  final double stickyCtaHeight;
  final double bottomInset;
  final double sectionPadding;
  final double headingGap;
  final double stackGap;
  final TextStyle countdownFigure;
  final bool compact;

  static const desktop = MuttaViewport(
    metrics: MuttaMetrics.standard,
    heroHeight: 0,
    heroEmblem: 224,
    headlinerAvatar: 64,
    bottomNavHeight: 0,
    stickyCtaHeight: 0,
    bottomInset: 0,
    sectionPadding: 64,
    headingGap: 40,
    stackGap: 16,
    countdownFigure: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 40 / 32,
      letterSpacing: 1.6,
      color: _cream,
    ),
    compact: false,
  );

  /// Medidas del mockup. bottomInset = nav + CTA + space-lg + space-sm.
  /// sectionPadding, headingGap y stackGap espejan MuttaSpacing.
  static const mobile = MuttaViewport(
    metrics: MuttaMetrics.mobile,
    heroHeight: 580,
    heroEmblem: 80,
    headlinerAvatar: 48,
    bottomNavHeight: 64,
    stickyCtaHeight: 48,
    bottomInset: 144,
    sectionPadding: 40,
    headingGap: 16,
    stackGap: 12,
    countdownFigure: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1,
      color: _accent,
    ),
    compact: true,
  );

  MuttaViewport lerp(MuttaViewport other, double t) {
    return MuttaViewport(
      metrics: metrics.lerp(other.metrics, t),
      heroHeight: lerpDouble(heroHeight, other.heroHeight, t)!,
      heroEmblem: lerpDouble(heroEmblem, other.heroEmblem, t)!,
      headlinerAvatar: lerpDouble(headlinerAvatar, other.headlinerAvatar, t)!,
      bottomNavHeight: lerpDouble(bottomNavHeight, other.bottomNavHeight, t)!,
      stickyCtaHeight: lerpDouble(stickyCtaHeight, other.stickyCtaHeight, t)!,
      bottomInset: lerpDouble(bottomInset, other.bottomInset, t)!,
      sectionPadding: lerpDouble(sectionPadding, other.sectionPadding, t)!,
      headingGap: lerpDouble(headingGap, other.headingGap, t)!,
      stackGap: lerpDouble(stackGap, other.stackGap, t)!,
      countdownFigure: TextStyle.lerp(
        countdownFigure,
        other.countdownFigure,
        t,
      )!,
      compact: t < 0.5 ? compact : other.compact,
    );
  }
}

@immutable
class MuttaTokens extends ThemeExtension<MuttaTokens> {
  const new({
    required this.accent,
    required this.cream,
    required this.earth,
    required this.surfaceBase,
    required this.surfaceElevated,
    required this.surfaceSubtle,
    required this.surfaceSection,
    required this.surfacePanel,
    required this.borderDim,
    required this.borderGhost,
    required this.borderCard,
    required this.borderInput,
    required this.glass,
    required this.headerBorder,
    required this.sandHover,
    required this.accentWash,
    required this.spacing,
    required this.radii,
    required this.metrics,
    required this.mobileViewport,
    required this.desktopViewport,
    required this.accentGlow,
    required this.buttonGlow,
    required this.focusHalo,
    required this.posterShadow,
    required this.headerShadow,
  });

  final Color accent;
  final Color cream;
  final Color earth;
  final Color surfaceBase;
  final Color surfaceElevated;
  final Color surfaceSubtle;
  final Color surfaceSection;
  final Color surfacePanel;
  final Color borderDim;
  final Color borderGhost;
  final Color borderCard;
  final Color borderInput;
  final Color glass;
  final Color headerBorder;
  final Color sandHover;
  final Color accentWash;
  final MuttaSpacing spacing;
  final MuttaRadii radii;
  final MuttaMetrics metrics;
  final MuttaViewport mobileViewport;
  final MuttaViewport desktopViewport;

  MuttaViewport viewportFor(AppBreakpoint breakpoint) {
    if (breakpoint == AppBreakpoint.mobile) {
      return mobileViewport;
    }
    return desktopViewport;
  }

  final List<BoxShadow> accentGlow;
  final List<BoxShadow> buttonGlow;
  final List<BoxShadow> focusHalo;
  final List<BoxShadow> posterShadow;
  final List<BoxShadow> headerShadow;

  static const standard = MuttaTokens(
    accent: _accent,
    cream: _cream,
    earth: _earth,
    surfaceBase: _base,
    surfaceElevated: _elevated,
    surfaceSubtle: _subtle,
    surfaceSection: _lowest,
    surfacePanel: _panel,
    borderDim: _borderDim,
    borderGhost: _borderGhost,
    borderCard: _borderCard,
    borderInput: _borderInput,
    glass: _glass,
    headerBorder: _headerBorder,
    sandHover: _sandHover,
    accentWash: _accentWash,
    spacing: MuttaSpacing.standard,
    radii: MuttaRadii.standard,
    metrics: MuttaMetrics.standard,
    mobileViewport: MuttaViewport.mobile,
    desktopViewport: MuttaViewport.desktop,
    accentGlow: [
      BoxShadow(color: _accentSoft, blurRadius: 32, offset: Offset(0, 8)),
    ],
    buttonGlow: [
      BoxShadow(color: _accentButton, blurRadius: 20, offset: Offset(0, 6)),
    ],
    focusHalo: [BoxShadow(color: _accentHalo, spreadRadius: 3)],
    posterShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.85),
        blurRadius: 50,
        offset: Offset(0, 20),
      ),
    ],
    headerShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.60),
        blurRadius: 12,
        offset: Offset(0, 1),
      ),
    ],
  );

  @override
  MuttaTokens copyWith({
    Color? accent,
    Color? cream,
    Color? earth,
    Color? surfaceBase,
    Color? surfaceElevated,
    Color? surfaceSubtle,
    Color? surfaceSection,
    Color? surfacePanel,
    Color? borderDim,
    Color? borderGhost,
    Color? borderCard,
    Color? borderInput,
    Color? glass,
    Color? headerBorder,
    Color? sandHover,
    Color? accentWash,
    MuttaSpacing? spacing,
    MuttaRadii? radii,
    MuttaMetrics? metrics,
    MuttaViewport? mobileViewport,
    MuttaViewport? desktopViewport,
    List<BoxShadow>? accentGlow,
    List<BoxShadow>? buttonGlow,
    List<BoxShadow>? focusHalo,
    List<BoxShadow>? posterShadow,
    List<BoxShadow>? headerShadow,
  }) {
    return MuttaTokens(
      accent: accent ?? this.accent,
      cream: cream ?? this.cream,
      earth: earth ?? this.earth,
      surfaceBase: surfaceBase ?? this.surfaceBase,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      surfaceSection: surfaceSection ?? this.surfaceSection,
      surfacePanel: surfacePanel ?? this.surfacePanel,
      borderDim: borderDim ?? this.borderDim,
      borderGhost: borderGhost ?? this.borderGhost,
      borderCard: borderCard ?? this.borderCard,
      borderInput: borderInput ?? this.borderInput,
      glass: glass ?? this.glass,
      headerBorder: headerBorder ?? this.headerBorder,
      sandHover: sandHover ?? this.sandHover,
      accentWash: accentWash ?? this.accentWash,
      spacing: spacing ?? this.spacing,
      radii: radii ?? this.radii,
      metrics: metrics ?? this.metrics,
      mobileViewport: mobileViewport ?? this.mobileViewport,
      desktopViewport: desktopViewport ?? this.desktopViewport,
      accentGlow: accentGlow ?? this.accentGlow,
      buttonGlow: buttonGlow ?? this.buttonGlow,
      focusHalo: focusHalo ?? this.focusHalo,
      posterShadow: posterShadow ?? this.posterShadow,
      headerShadow: headerShadow ?? this.headerShadow,
    );
  }

  @override
  MuttaTokens lerp(ThemeExtension<MuttaTokens>? other, double t) {
    if (other is! MuttaTokens) {
      return this;
    }
    return MuttaTokens(
      accent: Color.lerp(accent, other.accent, t)!,
      cream: Color.lerp(cream, other.cream, t)!,
      earth: Color.lerp(earth, other.earth, t)!,
      surfaceBase: Color.lerp(surfaceBase, other.surfaceBase, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      surfaceSection: Color.lerp(surfaceSection, other.surfaceSection, t)!,
      surfacePanel: Color.lerp(surfacePanel, other.surfacePanel, t)!,
      borderDim: Color.lerp(borderDim, other.borderDim, t)!,
      borderGhost: Color.lerp(borderGhost, other.borderGhost, t)!,
      borderCard: Color.lerp(borderCard, other.borderCard, t)!,
      borderInput: Color.lerp(borderInput, other.borderInput, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      headerBorder: Color.lerp(headerBorder, other.headerBorder, t)!,
      sandHover: Color.lerp(sandHover, other.sandHover, t)!,
      accentWash: Color.lerp(accentWash, other.accentWash, t)!,
      spacing: spacing.lerp(other.spacing, t),
      radii: radii.lerp(other.radii, t),
      metrics: metrics.lerp(other.metrics, t),
      mobileViewport: mobileViewport.lerp(other.mobileViewport, t),
      desktopViewport: desktopViewport.lerp(other.desktopViewport, t),
      accentGlow: BoxShadow.lerpList(accentGlow, other.accentGlow, t)!,
      buttonGlow: BoxShadow.lerpList(buttonGlow, other.buttonGlow, t)!,
      focusHalo: BoxShadow.lerpList(focusHalo, other.focusHalo, t)!,
      posterShadow: BoxShadow.lerpList(posterShadow, other.posterShadow, t)!,
      headerShadow: BoxShadow.lerpList(headerShadow, other.headerShadow, t)!,
    );
  }
}

TextStyle _montserrat({
  required double size,
  required FontWeight weight,
  required double height,
  required double tracking,
  required Color color,
}) {
  return TextStyle(
    fontFamily: 'Montserrat',
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: size * tracking,
    color: color,
  );
}

TextStyle wordmarkTaglineStyle() {
  return _montserrat(
    size: 12,
    weight: FontWeight.w500,
    height: 16 / 12,
    tracking: 0.28,
    color: _cream,
  );
}

TextStyle taglineLeadStyle({required bool compact}) {
  return _montserrat(
    size: compact ? 18 : 32,
    weight: FontWeight.w500,
    height: 1.25,
    tracking: 0.28,
    color: _cream,
  );
}

TextStyle taglineMarkStyle({required bool compact}) {
  return _montserrat(
    size: compact ? 18 : 32,
    weight: FontWeight.w800,
    height: 1.25,
    tracking: 0.08,
    color: _cream,
  );
}

TextStyle _inter({
  required double size,
  required FontWeight weight,
  required double height,
  required Color color,
}) {
  return TextStyle(
    fontFamily: 'Inter',
    fontSize: size,
    fontWeight: weight,
    height: height,
    color: color,
  );
}

ThemeData muttaTheme() {
  const tokens = MuttaTokens.standard;
  const scheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _accent,
    onPrimary: _base,
    primaryContainer: _accent,
    onPrimaryContainer: _base,
    secondary: _earth,
    onSecondary: _base,
    secondaryContainer: Color(0xFF48473F),
    onSecondaryContainer: Color(0xFFB8B5AB),
    tertiary: _cream,
    onTertiary: _base,
    tertiaryContainer: _subtle,
    onTertiaryContainer: _cream,
    error: _error,
    onError: _onError,
    errorContainer: _errorContainer,
    onErrorContainer: _onErrorContainer,
    surface: _base,
    onSurface: _cream,
    surfaceDim: _base,
    surfaceBright: Color(0xFF3A3939),
    surfaceContainerLowest: _lowest,
    surfaceContainerLow: _elevated,
    surfaceContainer: _panel,
    surfaceContainerHigh: _high,
    surfaceContainerHighest: _highest,
    onSurfaceVariant: _earth,
    outline: _earth,
    outlineVariant: _outlineVariant,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: _inverseSurface,
    onInverseSurface: _onInverseSurface,
    inversePrimary: _inversePrimary,
    surfaceTint: _surfaceTint,
  );

  final textTheme = TextTheme(
    displayLarge: _montserrat(
      size: 56,
      weight: FontWeight.w800,
      height: 64 / 56,
      tracking: 0.08,
      color: _cream,
    ),
    displayMedium: _montserrat(
      size: 36,
      weight: FontWeight.w800,
      height: 44 / 36,
      tracking: 0.06,
      color: _cream,
    ),
    displaySmall: _montserrat(
      size: 32,
      weight: FontWeight.w500,
      height: 40 / 32,
      tracking: 0.2,
      color: _accent,
    ),
    headlineLarge: _montserrat(
      size: 32,
      weight: FontWeight.w700,
      height: 40 / 32,
      tracking: 0.05,
      color: _cream,
    ),
    headlineMedium: _montserrat(
      size: 24,
      weight: FontWeight.w700,
      height: 32 / 24,
      tracking: 0.04,
      color: _cream,
    ),
    headlineSmall: _montserrat(
      size: 18,
      weight: FontWeight.w600,
      height: 26 / 18,
      tracking: 0.03,
      color: _cream,
    ),
    bodyLarge: _inter(
      size: 18,
      weight: FontWeight.w400,
      height: 28 / 18,
      color: _cream,
    ),
    bodyMedium: _inter(
      size: 15,
      weight: FontWeight.w400,
      height: 24 / 15,
      color: _cream,
    ),
    bodySmall: _inter(
      size: 13,
      weight: FontWeight.w400,
      height: 20 / 13,
      color: _earth,
    ),
    labelLarge: _montserrat(
      size: 14,
      weight: FontWeight.w700,
      height: 18 / 14,
      tracking: 0.12,
      color: _cream,
    ),
    labelMedium: _montserrat(
      size: 12,
      weight: FontWeight.w600,
      height: 16 / 12,
      tracking: 0.14,
      color: _cream,
    ),
    labelSmall: _montserrat(
      size: 10,
      weight: FontWeight.w600,
      height: 14 / 10,
      tracking: 0.16,
      color: _earth,
    ),
  );

  final radius = BorderRadius.circular(tokens.radii.nested);
  final inputBorder = OutlineInputBorder(
    borderRadius: radius,
    borderSide: const BorderSide(color: _borderInput),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: _base,
    canvasColor: _base,
    splashColor: _accentHalo,
    highlightColor: _sandHover,
    textTheme: textTheme,
    extensions: const [tokens],
    iconTheme: const IconThemeData(color: _cream),
    dividerColor: _borderGhost,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: _accent,
      selectionColor: _accentHalo,
      selectionHandleColor: _accent,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _elevated,
      contentTextStyle: textTheme.bodyMedium,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: radius),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _elevated,
      hintStyle: textTheme.bodySmall,
      contentPadding: EdgeInsets.symmetric(
        horizontal: MuttaSpacing.standard.md,
        vertical: MuttaSpacing.standard.sm,
      ),
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: _accent, width: 1.5),
      ),
      disabledBorder: inputBorder,
    ),
  );
}

extension MuttaThemeContext on BuildContext {
  MuttaTokens get tokens => Theme.of(this).extension<MuttaTokens>()!;

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get texts => Theme.of(this).textTheme;

  /// Escala del breakpoint heredado. Sin [AppLayout] usa desktop.
  MuttaViewport get viewport {
    final breakpoint = AppLayout.maybeOf(this);
    if (breakpoint == null) {
      return tokens.desktopViewport;
    }
    return tokens.viewportFor(breakpoint);
  }
}
