Pod::Spec.new do |s|
  s.name         = "SHSegueBlock"
  s.version      = "0.1.0"
  s.summary      = "Segue Blocks without swizzling and other junk hacks"
  s.description  = <<-DESC
                    Do segueus with blocks without any swizzling or leaks.
                    Blocks are hold with a weak reference so you don't have to cleanup when your vc is gone.
  
                    * No need to clean up after - Blocks are self maintained.
                    * Handles uninemplemented unwind segues
                    * Weak referenced blocks.
                    * No swizzling or hacks. 
                    * Name-scoped selectors.

                   DESC
  s.homepage     = "https://github.com/seivan/SHSegueBlock"
  s.license      = {:type => 'MIT' } 
  s.author       = { "Seivan Heidari" => "seivan.heidari@icloud.com" }
  
  s.source       = { :git => "https://github.com/seivan/SHSegueBlock.git", :tag => s.version.to_s }
  

  s.platform  = :ios, "5.0"

  s.source_files = 'SHSegueBlock/**/*.{h,m}'
  s.requires_arc = true
end
