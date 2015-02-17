
Pod::Spec.new do |s|
  s.name             = "ALEArchiver"
  s.version          = "0.1.0"
s.summary          = "A component which simplifies the process of archiving any object witch conforms to NSCoding using NSKeyedArchiver and saving them to disk."
  s.homepage         = "https://github.com/ale84/ALEArchiver"
  s.license          = 'MIT'
  s.author           = { "alessio" => "alessiodeveloper@gmail.com" }
  s.source           = { :git => "https://github.com/ale84/ALEArchiver.git", :tag => "v.0.1.0"}
  s.social_media_url = 'https://twitter.com/ale84'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'ALEArchiver'
  s.resource_bundles = {
    'ALEArchiver' => ['Pod/Assets/*.png']
  }

end
