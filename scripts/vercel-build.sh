#!/usr/bin/env bash
# Instala Flutter stable y construye la landing web para Vercel.
# Uso:
#   bash scripts/vercel-build.sh            # install + build
#   bash scripts/vercel-build.sh install    # clone, pub get, build_runner
#   bash scripts/vercel-build.sh build      # flutter build web --release
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

FLUTTER_DIR="${FLUTTER_HOME:-$HOME/flutter}"

ensure_flutter() {
  if [[ -x "$FLUTTER_DIR/bin/flutter" ]]; then
    export PATH="$FLUTTER_DIR/bin:$PATH"
    return
  fi
  if command -v flutter >/dev/null 2>&1; then
    return
  fi
  echo "Instalando Flutter stable en $FLUTTER_DIR"
  rm -rf "$FLUTTER_DIR"
  git clone --depth 1 -b stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
  export PATH="$FLUTTER_DIR/bin:$PATH"
}

configure_flutter() {
  flutter config --no-analytics >/dev/null
  flutter config --enable-web
}

install_deps() {
  ensure_flutter
  configure_flutter
  flutter pub get
  if grep -q "build_runner" pubspec.yaml; then
    dart run build_runner build --delete-conflicting-outputs
  fi
}

build_web() {
  ensure_flutter
  configure_flutter
  flutter build web --release
}

phase="${1:-all}"
case "$phase" in
  install) install_deps ;;
  build) build_web ;;
  all) install_deps && build_web ;;
  *)
    echo "Uso: scripts/vercel-build.sh [install|build|all]" >&2
    exit 1
    ;;
esac
