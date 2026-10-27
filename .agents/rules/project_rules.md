---
trigger: always_on
description: Reglas fundamentales de arquitectura, Git workflow y Flutter para MUTTA Web
---

# Reglas de Trabajo para MUTTA Web

## 1. Flujo de Trabajo en Git y Despliegues
- **NO hacer push directo a la rama `main`**.
- Trabajar siempre en **ramas efímeras** (`feat/...`, `fix/...`).
- Crear siempre un Pull Request con `gh pr create` hacia `main`.
- Vercel compila automáticamente cada PR para generar el preview.
- **Borrado post-merge obligatorio:** Una vez mergeado el PR, la rama efímera debe eliminarse (remota y localmente) y volver a `main` actualizado (`git checkout main && git pull`). Prohibido acumular ramas obsoletas.

## 2. Tecnologías y Estándares de Código
- Proyecto: **Flutter Web** desplegado en **Vercel** (`scripts/vercel-build.sh`).
- Seguir las reglas de `package:very_good_analysis` (cero warnings).
- Usar `color.withValues(alpha: ...)` para opacidades.
- Envolver llamadas asíncronas no esperadas en `initState` con `unawaited(...)` de `dart:async`.
- Si se necesita un icono nuevo de Material, registrarlo en `lib/core/icons/mutta_icons.dart`.

## 3. Diseño y Responsive
- Consultar siempre los tokens en `context.tokens` (`mutta_theme.dart`).
- Todo cambio visual debe considerar vista desktop y vista mobile (`_WideHero` / `_MobileHero`).
- Fondo base: `#0B0B0B`. Acento: `#FF8A37`. Textos: Cream `#F6F2E7`.

## 4. Assets y Multimedia
- Contenidos del evento en `assets/content/event.json`.
- Para videos de fondo en Flutter Web: obligatorio `volume = 0` (muted) y `loop = true` para compatibilidad de autoplay en navegadores.
