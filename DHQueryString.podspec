Pod::Spec.new do |s|

  s.name         = "DHQueryString"
  s.version      = "0.1.2"
  s.summary      = "QueryString Encoder/Decoder For Swift"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                   - QueryString Encoder/Decoder For Swift
                   DESC

  s.homepage     = "https://github.com/drahot/DHQueryString"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Tatsuya Hotta" => "hotterdragon@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/drahot/DHQueryString.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.swift"
  s.frameworks  = "Foundation"
  s.requires_arc = true
end
