Pod::Spec.new do |s|
    s.name             = "MCDingTalk"
    s.version          = "1.0.1"
    s.summary          = "DTShareKit官方库映射"
    s.description      = "MCDingTalk是对DTShareKit的映射，使用pod依赖管理，便于开发者快速集成DTShareKit的登录、分享等功能。"
    s.license          = 'MIT'
    s.author           = { "littleplayer" => "mailjiancheng@163.com" }
    s.homepage         = "https://github.com/poholo/MCDingTalk"
    s.source           = { :git => "https://github.com/poholo/MCDingTalk.git", :tag => s.version.to_s }

    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.vendored_frameworks = 'Example/DTShareKit.framework'
    
end
