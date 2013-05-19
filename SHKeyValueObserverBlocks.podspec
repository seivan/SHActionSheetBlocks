Pod::Spec.new do |s|
  name    = "SHKeyValueObserverBlocks"
  url     = "https://github.com/seivan/#{name}"
  git_url = "#{url}.git"
  s.name         = name
  s.version      = "1.0.0"
  s.summary      = "KVO Observer Blocks prefixed without swizzling."
  s.description  = <<-DESC
                    
                    DESC

  s.homepage     = url
  s.license      = {:type => 'MIT' } 
  s.author       = { "Seivan Heidari" => "seivan.heidari@icloud.com" }
  
  s.source       = { :git => git_url, :tag => s.version.to_s }
  

  s.platform  = :ios, "6.0"

  s.source_files = "#{name}/**/*.{h,m}"
  s.requires_arc = true
end
