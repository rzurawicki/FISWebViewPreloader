Pod::Spec.new do |s|

  s.name         = "FISWebViewPreloader"
  s.version      = "0.2"
  s.summary      = "Preloading WKWebViews in UIViewControllers for faster loadtime."
  s.homepage     = "https://github.com/rzurawicki/FISWebViewPreloader"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.authors       = { "Basar Akyelli" => "bakyelli@gmail.com", "James Lin" => "jameslin101@gmail.com" }

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/rzurawicki/FISWebViewPreloader.git", 
                     :tag => "0.2" }

  s.source_files  = 'FISWebViewPreloader/*.{h,m}'

  s.requires_arc = true
  
end
