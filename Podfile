source 'git@gitlab.tlabscloud.com:falcon/falcon-frontend-ios-podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'immmr-ios-recruiting' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!

  # Pods for immmr-ios-recruiting
  pod 'AFNetworking'
  pod 'MACollectionUtilities'
  pod 'SDWebImage'
  pod 'ReactiveCocoa', '5.0.0-alpha.1'
  pod 'ReactiveObjC', '1.0.0-alpha.1'
  pod 'ReactiveObjCBridge', '1.0.0-alpha.1'
  pod 'ReactiveSwift', '1.0.0-alpha.1'

  target 'immmr-ios-recruitingTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'OCMock'
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
