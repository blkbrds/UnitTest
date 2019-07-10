#!/bin/sh

# Create a custom keychain
security create-keychain -p travis ios-build.keychain

# Make the custom keychain default, so xcodebuild will use it for signing
security default-keychain -s ios-build.keychain

# Unlock the keychain
security unlock-keychain -p travis ios-build.keychain

# Set keychain timeout to 1 hour for long builds
# see http://www.egeek.me/2013/02/23/jenkins-and-xcode-user-interaction-is-not-allowed/
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

# Add certificates to keychain and allow codesign to access them
security import ./Cers/dev.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./Cers/dev.p12 -k ~/Library/Keychains/ios-build.keychain -P 12345678 -T /usr/bin/codesign

security import ./Cers/prod.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./Cers/prod.p12 -k ~/Library/Keychains/ios-build.keychain -P 12345678 -T /usr/bin/codesign

security set-key-partition-list -S apple-tool:,apple: -s -k travis ios-build.keychain

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "./Cers/provisioning_app_buildapp_testing_new.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
cp "./Cers/provisioning_app_buildapp_testing_prod.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
