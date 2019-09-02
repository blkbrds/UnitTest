#!/bin/bash

ios-build.keychain=ios-build.keychain
security create-keychain -p travis ios-build.keychain
# Make the keychain the default so identities are found
security default-keychain -s ios-build.keychain
# Unlock the keychain
security unlock-keychain -p travis ios-build.keychain
# Set keychain locking timeout to 3600 seconds
security set-keychain-settings -t 3600 -u ios-build.keychain

# Add certificates to keychain and allow codesign to access them
security import ./Cers/dis.cer -k ios-build.keychain -T /usr/bin/codesign
security import ./Cers/dev.cer -k ios-build.keychain -T /usr/bin/codesign

security import ./Cers/dis.p12 -k ios-build.keychain -P 12345678  -T /usr/bin/codesign
security import ./Cers/dev.p12 -k ios-build.keychain -P 12345678  -T /usr/bin/codesign

security set-key-partition-list -S apple-tool:,apple: -s -k travis ~/Library/Keychains/ios-build.keychain

echo "list keychains: "
security list-keychains
echo " ****** "

echo "find indentities keychains: "
security find-identity -p codesigning  ~/Library/Keychains/ios-build.keychain
echo " ****** "

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

uuid=`grep UUID -A1 -a ./scripts/profiles/Fastlane_dev.mobileprovision | grep -io "[-A-F0-9]\{36\}"`
cp ./Cers/Fastlane_dev.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/$uuid.mobileprovision

uuid=`grep UUID -A1 -a ./scripts/profiles/TheLastProject_AdHoc.mobileprovision | grep -io "[-A-F0-9]\{36\}"`
cp ./Cers/TheLastProject_AdHoc.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/$uuid.mobileprovision

#cp ./scripts/profiles/TheLastProject_Dev.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
#cp ./scripts/profiles/TheLastProject_AdHoc.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/

echo "show provisioning profile"
ls ~/Library/MobileDevice/Provisioning\ Profiles
echo " ****** "