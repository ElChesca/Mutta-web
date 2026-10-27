# Guía de Desarrollo y Reglas para Agentes — MUTTA Web

Este documento establece las directivas obligatorias para cualquier agente o desarrollador que trabaje en el repositorio **MUTTA-WEB** (`ElChesca/Mutta-web`).

---

## 1. Contexto del Proyecto

* **Objetivo:** Landing page oficial de la experiencia electrónica **MUTTA Sunset** en Boxes Potrero de los Funes, San Luis (Headliner: Mariano Mellino).
* **Tecnología:** **Flutter Web** (Dart SDK `^3.13.7` / Flutter stable).
* **Infraestructura:** Despliegue en **Vercel** automatizado mediante `scripts/vercel-build.sh` y `vercel.json`.
* **Repositorio GitHub:** `https://github.com/ElChesca/Mutta-web`.

---

## 2. Flujo de Trabajo Git y Despliegues (Estricto)

1. **PROHIBIDO el push directo a `main`:**
   * Todo cambio debe desarrollarse en una rama separada con convención: `feat/...`, `fix/...`, `refactor/...`, `chore/...`.
2. **Pull Requests (PR):**
   * Crear siempre el PR hacia `main` usando GitHub CLI:
     ```bash
     gh pr create --title "..." --body "..."
     ```
3. **Validación en Vercel:**
   * Cada PR genera un *Preview Deployment* automático en Vercel.
   * Antes de dar por finalizada una tarea, verificar el estado de los checks con `gh pr checks <PR_NUM>`.

---

## 3. Estándares de Código y Calidad (Dart & Flutter)

* **Análisis estricto:** El proyecto implementa `package:very_good_analysis`.
  * **Cero linter warnings:** No introducir warnings de análisis.
  * **Asincronía:** Siempre envolver futuros descartados en `initState` con `unawaited(...)` de `dart:async`.
  * **Colores y estilos:** Usar la API moderna de colores de Flutter `color.withValues(alpha: ...)` en vez del deprecado `withOpacity(...)`.
  * **Null Safety:** Tipado fuerte y manejo explícito de nulabilidad. No abusar de `late` cuando la variable deba ser `?`.
* **Iconografía:**
  * No instanciar `Icons.<name>` sueltos en las vistas si pertenecen al catálogo de diseño.
  * Si se necesita un icono nuevo, registrarlo en el switch centralizado de `lib/core/icons/mutta_icons.dart`.

---

## 4. Arquitectura de Carpetas

```
lib/
├── app.dart                   # Configuración de MaterialApp y GoRouter
├── main.dart                  # Punto de entrada con ProviderScope
├── core/
│   ├── icons/                 # mutta_icons.dart (catálogo unificado)
│   ├── layout/                # Responsive breakpoints, ContentFrame
│   ├── theme/                 # mutta_theme.dart (tokens, métricas, colores)
│   └── widgets/               # Botones, textos de marca, pills de estado
├── data/
│   ├── models/                # Modelos serializables (event_content.dart)
│   └── providers.dart         # Riverpod providers para cargar contenido
└── features/
    └── landing/
        ├── logic/             # Enlaces externos, utilitarios de interacción
        └── presentation/      # landing_page.dart y widgets por sección
```

---

## 5. Sistema de Diseño y Responsive

* **Tokens de diseño:** Todos los márgenes, gaps, colores y bordes deben consumirse desde `context.tokens`, `context.colors` o `context.texts` en `mutta_theme.dart`.
* **Identidad cromática:**
  * Fondo base oscuro: `#0B0B0B` (`tokens.surfaceBase`).
  * Acento atardecer/ámbar: `#FF8A37` (`tokens.colors.primary` / `accentWash`).
  * Tipografías: Cream `#F6F2E7` sobre superficies oscuras.
* **Diseño Mobile-First & Desktop:**
  * Siempre verificar tanto la vista desktop (`_WideHero`, layouts en fila) como la vista móvil (`_MobileHero`, navegación colapsada).
  * Respetar los breakpoints definidos en `lib/core/layout/app_breakpoint.dart`.

---

## 6. Manejo de Contenido y Multimedia

* **Textos y datos del evento:**
  * Están desacoplados en `assets/content/event.json`.
  * Modificaciones en fechas, links de Instagram, DJs o textos del Hero deben actualizarse allí.
* **Videos y Assets pesados:**
  * Para video de fondo en Flutter Web, **es obligatorio `volume = 0` (silenciado) y `loop = true`** para permitir `autoplay` en Chrome, Safari e iOS.
  * Los videos deben registrarse en `pubspec.yaml` bajo `flutter: assets:`.
  * Mantener los archivos multimedia comprimidos (preferentemente < 5 MB para web).
