# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
workspace 'ios_plugin'
project 'plugin.xcodeproj'
def settings
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  pod 'FirebaseCore', '5.4.0'
  pod 'FirebaseMessaging', '3.4.0'
end
target 'iOSObjectiveCPlugin' do
  settings
  target 'iOSObjectiveCPluginTests' do
    inherit! :search_paths
    # Pods for testing
  end
end
target 'iOSSwiftPlugin' do
  use_frameworks!
  settings
  target 'iOSSwiftPluginTests' do
    inherit! :search_paths
    # Pods for testing
  end
end
