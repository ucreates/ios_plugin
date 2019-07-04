Pod::Spec.new do |s|
  s.name         = 'iOSObjectiveCPlugin'
  s.version      = '1.0.0'
  s.summary      = 'iOSPlugin(iOSObjectiveC)'
  s.description  = 'sample'
  s.homepage     = 'https://github.com/ucreates/ios_plugin'
  s.license      = 'MIT'
  s.author             = { 'U-CREATES' => 'ucreates.inc@gmail.com' }
  s.social_media_url   = 'https://twitter.com/UCreates'
  s.platform     = :ios, '10.0'
  s.source       = { git: 'https://github.com/ucreates/ios_plugin.git', branch: 'master' }
  s.source_files  = 'iOSObjectiveCPlugin/**/*.{h,m}'
  s.exclude_files = ''
  s.static_framework = true
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Messaging'
end
