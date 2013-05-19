Pod::Spec.new do |s|
  name    = "SHKeyValueObserverBlocks"
  url     = "https://github.com/seivan/#{name}"
  git_url = "#{url}.git"
  s.name         = name
  s.version      = "1.0.0"
  s.summary      = "KVO Observer Blocks prefixed without swizzling."
  s.description  = <<-DESC

                    Now you can do Key Value Observing with blocks without any swizzling or leaks.
                    Cleaner code base than most implementations.
                    Blocks are hold with a weak reference so you don't have to cleanup when your object is gone.
  
                    * No need to clean up after - Blocks are self maintained.
                    * Weak referenced blocks.
                    * No swizzling or hacks. 
                    * Name-scoped selectors.
                    * Works with existing codebase that uses old fashioned observing delegate calls. 
                    
                    DESC

  s.homepage     = url
  s.license      = {:type => 'MIT' } 
  s.author       = { "Seivan Heidari" => "seivan.heidari@icloud.com" }
  
  s.source       = { :git => git_url, :tag => s.version.to_s }
  

  s.platform  = :ios, "6.0"

  s.source_files = "#{name}/**/*.{h,m}"
  s.requires_arc = true
end
