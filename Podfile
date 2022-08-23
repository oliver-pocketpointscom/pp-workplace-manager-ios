platform :ios, 13.0
inhibit_all_warnings!
use_frameworks!

def use_libraries
  pod 'SnapKit', '~> 5.6.0'
  pod 'iOSDropDown'
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
    end
  end
end
