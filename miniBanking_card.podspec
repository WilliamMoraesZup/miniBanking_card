Pod::Spec.new do |spec|
  spec.name          = "miniBanking_card"
  spec.version       = "0.0.1"
  spec.summary       = "Login module for miniBanking app"
  spec.description   = "Module containing card feature for miniBanking app"
  spec.homepage      = "https://github.com/brunovsc/miniBanking_card.git"
  spec.license       = "None"
  spec.author        = { "Bruno Vieira" => "brunoscvieira@gmail.com" }
  spec.platform      = :ios, 13.0
  spec.swift_version = '5.0'
  spec.source        = { :git => "https://github.com/brunovsc/miniBanking_card.git", :tag => "#{spec.version}" }
  spec.subspec 'Development' do |dev|
    dev.subspec 'Sources' do |src|
      src.source_files = '**/*.{swift}'
    end
    dev.subspec 'Resources' do |rsc|
      rsc.resources    = '**/*.{xcassets,storyboard,xib}'
    end
  end
  spec.dependency "miniBanking_core", "~> 0.0"
end
