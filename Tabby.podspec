Pod::Spec.new do |s|
  s.name             = "Tabby"
  s.summary          = "If cats looked like frogs we'd realize what nasty, cruel little bastards they are. Style. That's what people remember."
  s.version          = "0.1.0"
  s.homepage         = "https://github.com/hyperoslo/Tabby"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = {
    :git => "https://github.com/hyperoslo/Tabby.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*'
end
