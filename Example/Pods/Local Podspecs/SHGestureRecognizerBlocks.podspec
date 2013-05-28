Pod::Spec.new do |s|
  name    = "SHGestureRecognizerBlocks"
  url     = "https://github.com/seivan/#{name}"
  git_url = "#{url}.git"
  s.name         = name
  s.version      = "0.1.0"
  s.summary      = "Prefixed self removing gesture recognizers with blocks."
  s.description  = <<-DESC

                    Gesture Recognizers with blocks.
                    Blocks are hold with a weak reference so you don't have to cleanup when your object is gone.
  
                    * No need to clean up after - Blocks and observers are self maintained.
                    * Weak referenced blocks.
                    * Prefixed selectors.
                    * Works with existing codebase that uses old fashioned observing delegate calls. 
                    * Minimum clutter on top of the public interface.

                    
                    DESC

  s.homepage     = url
  s.license      = 'MIT'
  s.author       = { "Seivan Heidari" => "seivan.heidari@icloud.com" }
  
  s.source       = { :git => git_url, :tag => s.version.to_s }
  

  s.platform  = :ios, "6.0"

  s.source_files = "#{name}/**/*.{h,m}"
  s.requires_arc = true
end
