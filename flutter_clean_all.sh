#!/bin/bash

# flutter_clean_all.sh
# Schoont Flutter-project op inclusief gedeelde caches (.gradle, .pub-cache)

# --- Veiligheidscheck ---
if [ ! -f "pubspec.yaml" ] || [ ! -d "lib" ]; then
    echo "❌ Dit lijkt geen Flutter-projectdirectory te zijn."
    echo "    Start dit script vanuit de hoofdmap van je Flutter-project."
    exit 1
fi

echo "✅ Flutter-project gevonden: $(basename "$PWD")"
echo "🧹 Bezig met opschonen..."

# Flutter & Dart cache
rm -rf build/ .dart_tool/

# Android build caches
rm -rf android/build/ android/.gradle/ android/app/build/

# iOS / macOS build caches
rm -rf ios/Pods/ ios/Flutter/Flutter.framework ios/Flutter/Flutter.podspec ios/build/
rm -rf macos/Pods/ macos/Flutter/ephemeral macos/build/

# Web build cache
rm -rf web/build/

# Windows / Linux desktop build caches
rm -rf windows/build/ linux/build/

# Globale caches
rm -rf "$HOME/.pub-cache/hosted"
rm -rf "$HOME/.gradle"

echo "✅ Opschonen voltooid."
echo "ℹ️  Vergeet niet om 'flutter pub get' uit te voeren voordat je opnieuw buildt."

