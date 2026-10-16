#!/bin/bash
set -e
​echo "=== Preparing Web Directory ==="
mkdir -p www
cp index.html www/index.html
​echo "=== Initializing Capacitor Project ==="
npm init -y
npm install @capacitor/core@6.1.2 @capacitor/cli@6.1.2 @capacitor/android@6.1.2
​echo "=== Creating Capacitor Configuration ==="
cat << 'EOF' > capacitor.config.json
{
"appId": "com.arulkrish.aurapulse",
"appName": "AuraPulse Studio",
"webDir": "www",
"bundledWebRuntime": false,
"server": {
"androidScheme": "https"
}
}
EOF
​echo "=== Adding Android Platform ==="
npx cap add android
​echo "=== Injecting Background Audio & Lockscreen Permissions ==="
sed -i '/<application/i \    <uses-permission android:name="android.permission.WAKE_LOCK" />\n    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />\n    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK" />' android/app/src/main/AndroidManifest.xml
​echo "=== Syncing Capacitor Android Platform ==="
npx cap sync android
​echo "=== Building Debug APK with Gradle ==="
cd android
chmod +x gradlew
./gradlew assembleDebug --no-daemon
​echo "=== Build Completed Successfully! ==="
