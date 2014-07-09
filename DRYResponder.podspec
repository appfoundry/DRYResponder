Pod::Spec.new do |s|

  s.name         = "DRYResponder"
  s.version      = "1.1.0"
  s.summary      = "iOS Implementation of Responder/CallHandle."
  s.description  = <<-DESC
                   The iOS implementation of the Responder and CallHandle concepts
				   described in the remoting architecture presented at AppFoundry
				   by Mike Seghers & Filip Maelbrancke. (http://parleys.com/play/517a9286e4b0c6dcd9546458)
                   DESC
  s.homepage     = "https://github.com/appfoundry/DRYResponder"
  s.requires_arc = true
  s.license      = 'MIT'
  s.authors      = { "Alex Manarpies" => "alex.manarpies@ida-mediafoundry.be", "Mike Seghers" => "michael.seghers@ida-mediafoundry.be" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/appfoundry/DRYResponder.git", :tag => "1.1.0" }
  s.source_files  = 'DRYResponder/Classes', 'DRYResponder/Classes/**/*.{h,m}'

end
