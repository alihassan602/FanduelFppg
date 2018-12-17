platform :ios, "12"

use_frameworks!
inhibit_all_warnings!
install! 'cocoapods', :deterministic_uuids => false

target 'FanduelFppg' do
 pod 'Alamofire'
  pod 'CodableAlamofire', :git => 'https://github.com/xdci/CodableAlamofire'
  pod 'TinyConstraints', :git => 'https://github.com/roberthein/TinyConstraints.git', :branch => 'release/Swift-4.2'
  pod 'Nuke'

  # Pods for FanduelFppg

  target 'FanduelFppgTests' do
     inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

end
