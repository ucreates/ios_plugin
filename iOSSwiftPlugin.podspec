Pod::Spec.new do |s|
  s.name         = 'iOSSwiftPlugin'
  s.version      = '1.0.0'
  s.summary      = 'Plugin(Swift)'
  s.description  = 'Plugin for iOS/Swift'
  s.homepage     = 'https://github.com/ucreates/ios_plugin'
  s.license      = 'MIT'
  s.author             = { 'U-CREATES' => 'ucreates.inc@gmail.com' }
  s.social_media_url   = 'https://twitter.com/UCreates'
  s.platform     = :ios, '10.0'
  s.source       = { git: 'https://github.com/ucreates/ios_plugin.git', branch: 'master' }
  s.source_files  = 'iOSSwiftPlugin/**/*.swift'
  s.exclude_files = ''
  s.static_framework = true
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/Firebase/CoreOnly/Sources' }
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Messaging'
end
