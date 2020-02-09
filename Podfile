# Uncomment the next line to define a global platform for your project
platform :ios, '12.4'
plugin 'cocoapods-binary'
all_binary!
target 'UnitTestExample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftLint', '0.33.0'
  pod 'Fabric', '1.10.2'
  pod 'Crashlytics', '3.13.4'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'

  target 'UnitTestExampleTests' do
    inherit! :search_paths
  end

end
