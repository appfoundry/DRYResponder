Pod::Spec.new do |s|

  s.name         = "DRYResponder"
  s.version      = "1.0.2"
  s.summary      = "iOS Implementation of Responder/CallHandle."
  s.description  = <<-DESC
                   The iOS implementation of the Responder and CallHandle concepts
				   described in the remoting architecture presented at iDA MediaFoundry
				   by Mike Seghers & Filip Maelbrancke.
                   DESC
  s.homepage     = "https://bitbucket.org/idamediafoundry/dryresponder/"
  s.license      = 'Apache License, Version 2.0'
  s.authors      = { "Alex Manarpies" => "alex.manarpies@ida-mediafoundry.be", "Mike Seghers" => "michael.seghers@ida-mediafoundry.be" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "ssh://git@bitbucket.org/idamediafoundry/dryresponder.git", :tag => "1.0.2" }
  s.source_files  = 'DRYResponder/Classes', 'DRYResponder/Classes/**/*.{h,m}'

end