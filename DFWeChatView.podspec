
Pod::Spec.new do |s|


  s.name         = "DFWeChatView"
  s.version      = "1.1.2"
  s.summary      = "仿微信聊天界面"

  s.homepage     = "https://github.com/anyunzhong/DFWeChatView"

  s.license      = "MIT (example)"


  s.author             = { "Fast-Dev-Kit" => "2642754767@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/anyunzhong/DFWeChatView.git", :tag => "1.1.2" }


  s.source_files  = "DFWeChatView/DFChatView/**/*.{h,m}"

  s.resources = "DFWeChatView/DFChatView/Resource/*"

  s.frameworks = "AVFoundation", "AssetsLibrary"


  s.requires_arc = true


  s.dependency "FLAnimatedImage", "~> 1.0.8"

end
