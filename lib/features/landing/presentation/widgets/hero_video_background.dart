import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:video_player/video_player.dart';

/// Fondo de video cinemático para la sección Hero de MUTTA Sunset.
///
/// Reproduce `assets/videos/teaser.mp4` en bucle, muteado por defecto para
/// cumplir las políticas de autoplay de los navegadores (Chrome, Safari, iOS),
/// con un botón discreto de audio para que el usuario pueda activar el sonido.
class HeroVideoBackground extends StatefulWidget {
  const HeroVideoBackground({
    this.videoAsset = 'assets/videos/teaser.mp4',
    this.showAudioToggle = true,
    super.key,
  });

  final String videoAsset;
  final bool showAudioToggle;

  @override
  State<HeroVideoBackground> createState() => _HeroVideoBackgroundState();
}

class _HeroVideoBackgroundState extends State<HeroVideoBackground> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _muted = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initVideo());
  }

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.asset(widget.videoAsset);
      _controller = controller;
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0); // Autoplay permitido por navegadores
      await controller.play();

      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _toggleAudio() {
    final controller = _controller;
    if (controller == null || !_initialized) return;
    final nextMuted = !_muted;
    unawaited(controller.setVolume(nextMuted ? 0.0 : 1.0));
    setState(() {
      _muted = nextMuted;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final controller = _controller;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Resplandor base ambiental de respaldo (siempre presente o mientras carga)
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.8),
                radius: 0.9,
                colors: [tokens.accentWash, const Color(0x00000000)],
              ),
            ),
          ),
        ),

        // 2. Capa de Video (con fade in suave)
        if (_initialized && !_hasError && controller != null)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: 0.70, // Balance entre el video y la legibilidad de la marca
                curve: Curves.easeOut,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
            ),
          ),

        // 3. Vignette y gradientes de legibilidad (Sunset Mood)
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 0.85, 1.0],
                  colors: [
                    tokens.surfaceBase.withValues(alpha: 0.75), // Arriba (header)
                    tokens.surfaceBase.withValues(alpha: 0.45), // Centro
                    tokens.surfaceBase.withValues(alpha: 0.85), // Previo al corte
                    tokens.surfaceBase,                         // Abajo (100% sólido)
                  ],
                ),
              ),
            ),
          ),
        ),

        // 4. Lavado sutil color ámbar / atardecer de MUTTA
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.4, -0.3),
                  radius: 1.1,
                  colors: [
                    tokens.accentWash.withValues(alpha: 0.25),
                    const Color(0x00000000),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 5. Botón discreto flotante para mutear / desmutear el teaser
        if (widget.showAudioToggle && _initialized && !_hasError)
          Positioned(
            right: tokens.spacing.margin,
            bottom: tokens.spacing.lg,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _toggleAudio,
                borderRadius: BorderRadius.circular(tokens.radii.pill),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.md,
                    vertical: tokens.spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: tokens.surfaceBase.withValues(alpha: 0.70),
                    borderRadius: BorderRadius.circular(tokens.radii.pill),
                    border: Border.all(
                      color: colors.outlineVariant.withValues(alpha: 0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        muttaIcon(_muted ? 'volume_off' : 'volume_up'),
                        color: _muted ? colors.onSurfaceVariant : colors.primary,
                        size: tokens.metrics.iconSm,
                      ),
                      SizedBox(width: tokens.spacing.xs),
                      Text(
                        _muted ? 'Audio' : 'Sonando',
                        style: context.texts.labelSmall?.copyWith(
                          color: _muted
                              ? colors.onSurfaceVariant
                              : colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
