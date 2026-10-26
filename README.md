# MUTTA Sunset

Landing web del evento **MUTTA Sunset** (sábado 19 de diciembre, Boxes Potrero de los Funes, San Luis). La interfaz sigue el mockup de Stitch y el design system: fondo `#0B0B0B`, acento `#FF8A37`, texto `#F6F2E7` y gris `#A7A097`, con Montserrat e Inter.

## Requisitos

- Flutter stable (el entorno de desarrollo de este repo usó 3.47).
- Chrome, para `flutter run -d chrome`.

## Cómo correrlo

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

La ruta de la landing es `/` con path URL strategy (sin `#`).

Build de producción:

```bash
flutter build web --release
```

La salida queda en `build/web`. Se puede servir con cualquier hosting estático.

## Tests

```bash
flutter analyze
flutter test
```

Hay tests de texto del JSON, el countdown y el FAQ.

## Arquitectura

- `lib/core`: `ThemeData`, `ColorScheme` y `MuttaTokens` (`ThemeExtension`) con color, spacing, radios y glow. Los widgets leen el tema; no hardcodean la paleta.
- `lib/data`: `assets/content/event.json`, modelos `json_serializable` y `EventRepository`.
- `lib/features/landing`: presentación, notifiers de Riverpod (countdown, FAQ, menú móvil, newsletter) y navegación por scroll.
- `go_router` publica la landing en `/`.

Breakpoints con `LayoutBuilder`: móvil &lt; 768, tablet 768–1024, desktop &gt; 1024, ancho máximo 1320.

## Despliegue en Vercel

El build corre **en Vercel**. No hace falta subir `build/web`.

1. Entrá a [vercel.com/new](https://vercel.com/new) e importá el repositorio de GitHub `ElChesca/Mutta-web`.
2. Framework preset: **Other** (el `vercel.json` ya fija los comandos).
3. Production Branch: **`main`**. Los pushes a `main` despliegan producción. El resto de las ramas, incluido el PR, generan preview.
4. No hace falta definir variables de entorno para la landing estática.
5. Deploy. Vercel ejecuta:
   - `installCommand`: `bash scripts/vercel-build.sh install` — clona Flutter stable (`git clone --depth 1 -b stable`), `flutter config --enable-web`, `flutter pub get` y `build_runner` si el proyecto lo declara.
   - `buildCommand`: `bash scripts/vercel-build.sh build` — `flutter build web --release`.
6. `outputDirectory` es `build/web`. El rewrite `/(.*) → /index.html` deja funcionar la path URL strategy: un refresh en cualquier ruta sirve la app. Los archivos que sí existen (`assets/`, `canvaskit/`, JS) se sirven antes del rewrite.
7. Caché: `assets/` y `canvaskit/` salen con `Cache-Control: public, max-age=31536000, immutable`. `index.html`, `/`, `flutter_bootstrap.js`, `flutter_service_worker.js`, `flutter.js`, `main.dart.js` y `version.json` salen con `no-cache` porque esos nombres no cambian entre deploys.
8. El `<link rel="manifest">` lleva `crossorigin="use-credentials"` para que el manifest cargue en los previews con Deployment Protection.

En local, el mismo pipeline completo es:

```bash
bash scripts/vercel-build.sh
```

La primera vez clona Flutter en `$HOME/flutter` (o en `$FLUTTER_HOME` si está definido). Si `flutter` ya está en el `PATH`, lo reutiliza.

Los assets bajo `assets/` no llevan hash en el nombre. Si cambiás una imagen y el CDN sigue sirviendo la anterior, purgá la caché de ese deployment en Vercel.

## Pendientes

- Golden tests de componentes. Por ahora solo hay tests de comportamiento.
- Venta de entradas: «Comprar Tickets» y «Conseguir Entradas» muestran un aviso. El código está marcado con `TODO(mutta)`. No hay sección de pases.
- La sección «¿Qué es la experiencia MUTTA?», las features y la pulsera oficial salieron del layout. En ese lugar queda la franja «¿MÁS DE LO MISMO? MUTTA.».
- Newsletter: valida el email y deja el estado en pendiente de integración. No envía datos a ningún servicio.
- La muestra sonora del lineup solo alterna play/pausa. El mockup no incluye un archivo de audio.
- Términos de admisión y políticas de privacidad no tienen página en el mockup.
- No hay sección Galería: el ítem del header lleva al lineup, que es el bloque fotográfico.

## Desvíos respecto del mockup

- El fondo de página es `#0B0B0B`, como pide el texto de `DESIGN.md`, y no el token `#131313` del export.
- El acento es el naranja oficial `#FF8A37`. El «Amarillo Sol `#FFD93D`» del manual de marca queda descartado.
- El countdown apunta al sábado 19 de diciembre de 2026 a las 17:00 (ART), no al temporizador de demostración del HTML (`hoy + 24 días`).
- Las tarjetas usan radio 24 y los anidados 16, según la sección de formas del design system.
- El texto de display, headline y label va en mayúsculas, como pide el design system.
- «Galería» no existe como sección en el HTML.
- La compra y la newsletter son placeholders a propósito.
- A pedido de Fede, no se muestran pases, checkout, la experiencia ni la pulsera. El nav «Experiencia MUTTA» baja a la franja de tagline.
- El wordmark y el isotipo son SVG trazados desde los PNG oficiales, para que el borde escale sin escalones.
