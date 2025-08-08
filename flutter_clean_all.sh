#!/bin/bash

# flutter_clean_all.sh
# Cleans Flutter project + plugin build artifacts + global caches
# Auto-detects platform and skips irrelevant steps

# --- Safety check ---
if [ ! -f "pubspec.yaml" ] || [ ! -d "lib" ]; then
    echo "❌ This does not look like a Flutter project root."
    echo "    Run this script from your Flutter project's main directory."
    exit 1
fi

OS_TYPE="$(uname -s)"
echo "✅ Flutter project detected: $(basename "$PWD")"
echo "🧹 Cleaning build artifacts and caches on $OS_TYPE ..."

# --- Always remove ---
rm -rf build/ .dart_tool/

# --- Android ---
rm -rf android/build/ android/.gradle/ android/app/build/
rm -rf android/app/.cxx/ android/app/intermediates/ android/app/.externalNativeBuild/
rm -f  android/local.properties
# Android plugin metadata
rm -f  android/.flutter-plugins android/.flutter-plugins-dependencies

# --- Web ---
rm -rf build/web/ .dart_tool/flutter_build/

# --- Platform-specific cleanup ---
case "$OS_TYPE" in
    Darwin) # macOS
        echo "🔹 macOS/iOS cleanup..."
        rm -rf ios/Pods/ ios/build/ ios/Flutter/Flutter.framework ios/Flutter/Flutter.podspec ios/.symlinks/
        rm -f  ios/.flutter-plugins ios/.flutter-plugins-dependencies
        rm -rf macos/Pods/ macos/build/ macos/Flutter/ephemeral macos/.symlinks/
        rm -f  macos/.flutter-plugins macos/.flutter-plugins-dependencies
        ;;
    Linux)
        echo "🔹 Linux cleanup..."
        rm -rf linux/build/ linux/flutter/ephemeral
        rm -f  linux/.flutter-plugins linux/.flutter-plugins-dependencies
        rm -rf windows/build/ windows/flutter/ephemeral
        rm -f  windows/.flutter-plugins windows/.flutter-plugins-dependencies
        ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
        echo "🔹 Windows cleanup..."
        rm -rf windows/build/ windows/flutter/ephemeral
        rm -f  windows/.flutter-plugins windows/.flutter-plugins-dependencies
        rm -rf linux/build/ linux/flutter/ephemeral
        rm -f  linux/.flutter-plugins linux/.flutter-plugins-dependencies
        ;;
    *)
        echo "⚠ Unknown OS, running generic cleanup only."
        ;;
esac

# --- Global caches ---
rm -rf "$HOME/.pub-cache/hosted"
rm -rf "$HOME/.gradle"

echo "✅ Clean complete."
echo "ℹ️  Run 'flutter pub get' before your next build."
