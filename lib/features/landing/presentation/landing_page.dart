import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/data/providers.dart';
import 'package:mutta_web/features/landing/logic/external_link.dart';
import 'package:mutta_web/features/landing/presentation/widgets/closing_band.dart';
import 'package:mutta_web/features/landing/presentation/widgets/facts_section.dart';
import 'package:mutta_web/features/landing/presentation/widgets/gallery_section.dart';
import 'package:mutta_web/features/landing/presentation/widgets/hero_section.dart';
import 'package:mutta_web/features/landing/presentation/widgets/lineup_section.dart';
import 'package:mutta_web/features/landing/presentation/widgets/location_section.dart';
import 'package:mutta_web/features/landing/presentation/widgets/site_footer.dart';
import 'package:mutta_web/features/landing/presentation/widgets/site_header.dart';

class LandingPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  final _controller = ScrollController();
  final GlobalKey<State<StatefulWidget>> _hero = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _facts = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _lineup = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _gallery = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _location = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  GlobalKey? _keyFor(String id) {
    return switch (id) {
      'hero' => _hero,
      'facts' => _facts,
      'lineup' => _lineup,
      'gallery' => _gallery,
      'location' => _location,
      _ => null,
    };
  }

  void _scrollTo(String id) {
    final target = _keyFor(id)?.currentContext;
    final object = target?.findRenderObject();
    if (target != null && object != null) {
      final position = Scrollable.of(target).position;
      final revealed = RenderAbstractViewport.of(object)
          .getOffsetToReveal(object, 0)
          .offset;
      final width = MediaQuery.sizeOf(context).width;
      final header = context.tokens
          .viewportFor(breakpointFor(width))
          .metrics
          .headerHeight;
      final max = position.maxScrollExtent;
      final raw = revealed - header;
      final dest = raw < 0 ? 0.0 : (raw > max ? max : raw);
      position.animateTo(
        dest,
        duration: const Duration(milliseconds: 480),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _open(String url) async {
    final opened = await openExternal(Uri.parse(url));
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }

  void _tickets() {
    // TODO(mutta): conectar la pasarela de pago oficial cuando esté definida.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('TODO: la venta de entradas todavía no está conectada.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = ref.watch(eventContentProvider);
    return Scaffold(
      body: content.when(
        loading: () => const _Status(loading: true),
        error: (error, stackTrace) => _Status(
          loading: false,
          onRetry: () => ref.invalidate(eventContentProvider),
        ),
        data: (event) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final breakpoint = breakpointFor(constraints.maxWidth);
              final scale = context.tokens.viewportFor(breakpoint);
              final safe = MediaQuery.paddingOf(context).bottom;
              return AppLayout(
                breakpoint: breakpoint,
                child: FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Stack(
                    children: [
                      FocusTraversalOrder(
                        order: const NumericFocusOrder(2),
                        child: SelectionArea(
                          child: SingleChildScrollView(
                            controller: _controller,
                            padding: EdgeInsets.only(
                              top: scale.metrics.headerHeight,
                              bottom:
                                  scale.bottomInset +
                                  (breakpoint == AppBreakpoint.mobile
                                      ? safe
                                      : 0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                KeyedSubtree(
                                  key: _hero,
                                  child: HeroSection(
                                    hero: event.hero,
                                    tagline: event.tagline,
                                    onTickets: _tickets,
                                    onNext: () => _scrollTo('facts'),
                                  ),
                                ),
                                KeyedSubtree(
                                  key: _facts,
                                  child: FactsSection(facts: event.facts),
                                ),
                                KeyedSubtree(
                                  key: _lineup,
                                  child: LineupSection(lineup: event.lineup),
                                ),
                                KeyedSubtree(
                                  key: _gallery,
                                  child: GallerySection(gallery: event.gallery),
                                ),
                                KeyedSubtree(
                                  key: _location,
                                  child: LocationSection(
                                    location: event.location,
                                    onOpenMap: () => _open(event.event.mapsUrl),
                                  ),
                                ),
                                ClosingBand(
                                  title: event.footer.quote,
                                  cta: event.hero.primaryCta,
                                  onTickets: _tickets,
                                ),
                                SiteFooter(
                                  footer: event.footer,
                                  onInstagram: () =>
                                      _open(event.event.instagramUrl),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: FocusTraversalOrder(
                          order: const NumericFocusOrder(1),
                          child: SiteHeader(
                            chrome: event.chrome,
                            navigation: event.navigation,
                            onNavigate: _scrollTo,
                            onBuy: _tickets,
                          ),
                        ),
                      ),
                      if (breakpoint == AppBreakpoint.mobile)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: MobileChrome(
                            cta: event.hero.primaryCta,
                            onBuy: _tickets,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const new({required this.loading, this.onRetry});

  final bool loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ColoredBox(
      color: context.tokens.surfaceBase,
      child: Center(
        child: loading
            ? CircularProgressIndicator(color: colors.primary)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No pudimos cargar el evento.',
                    style: context.texts.bodyLarge,
                  ),
                  SizedBox(height: context.tokens.spacing.md),
                  MuttaButton(label: 'Reintentar', onPressed: onRetry),
                ],
              ),
      ),
    );
  }
}
