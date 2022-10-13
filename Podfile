platform :ios, 13.0
inhibit_all_warnings!
use_frameworks!

def use_libraries
  pod 'Alamofire', '4.7'
  pod 'AlamofireActivityLogger', :git => 'https://github.com/ManueGE/AlamofireActivityLogger.git', :tag => '2.4.0'
  pod 'SnapKit', '~> 5.6.0'
  pod 'iOSDropDown'
  pod 'RealmSwift', '10.11.0'
  pod 'Chargebee'
end

# Target Specific Dependencies
target 'WorkplaceManagerApp' do
  use_frameworks!
  use_libraries
end

target 'WorkplaceManagerAppTests' do
  use_frameworks!
  inherit! :search_paths
end

target 'WorkplaceManagerAppUITests' do
  use_frameworks!
  inherit! :search_paths
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end
