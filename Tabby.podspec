Pod::Spec.new do |s|
  s.name             = "Tabby"
  s.summary          = "Just another fancy tabbar"
  s.version          = "0.1.0"
  s.homepage         = "https://github.com/hyperoslo/Tabby"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = {
    :git => "https://github.com/hyperoslo/Tabby.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.ios.deployment_target = '9.0'

  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*'
  s.dependency 'Morgan'
end
