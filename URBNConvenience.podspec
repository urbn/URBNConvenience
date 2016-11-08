Pod::Spec.new do |s|
  s.name             = "URBNConvenience"
  s.version          = "2.0.5"
  s.summary          = "A pod for URBN convenience functions, macros, and categories."
  s.homepage         = "https://github.com/urbn/URBNConvenience"
  s.license          = 'MIT'
  s.author           = { "URBN Mobile Team" => "mobileteam@urbanout.com" }
  s.source           = { :git => "https://github.com/urbn/URBNConvenience.git", :tag => s.version.to_s }

  s.platforms = { :ios => "8.0", :tvos => "9.0" }
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources     = 'Pod/Resources/URBNConvenience.bundle'
end

