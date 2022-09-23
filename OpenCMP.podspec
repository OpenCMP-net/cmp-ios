Pod::Spec.new do |s|

  s.name         = "OpenCMP"
  s.version      = "1.0.5"
  s.summary      = "Traffective Consent Management Platform"
  s.description  = <<-DESC
  Das Traffective Consent Management Tool basiert auf dem vom Branchenverband IAB Europe eingeführten Standard, dem IAB Transparency & Consent Framework. Traffective ist offiziell gelisteter Consent Management Provider mit der ID 21.
  DESC

  s.homepage     = "https://traffective.com/solutions/#traffective-consent-management"
  s.screenshots  = "https://traffective.com/wp-content/uploads/2022/01/trf-platform-cmp.png"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Traffective GmbH" => "info@traffective.com" }

  s.platform     = :ios
  s.platform     = :ios, "11.0"

  s.source       = { :git => "git@bitbucket.org:traffective/cmp-ios.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/**/*.{h,swift,html}"
  s.exclude_files = "Tests/**/*"

  s.resources = ["**/Resources/*.html"]
  
  s.swift_version = "5.0"

end
