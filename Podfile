# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def common_pods
  pod 'Swinject'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
  pod 'Reusable'
  pod 'SwiftLint'
  pod 'R.swift'
  pod 'ReachabilitySwift'
  pod 'RxGesture'
  pod 'RxSwiftUtilities'
  pod 'lottie-ios'
  pod 'RxSwiftExt'
  pod 'SDWebImage'
end

target 'COCO' do
  # Comment the next line if you don't want to use dynamic frameworks
  inhibit_all_warnings!
    common_pods

  # Pods for COCO

  target 'COCOTests' do
    inhibit_all_warnings!
    inherit! :search_paths
    # Pods for testing
  end

  target 'COCOUITests' do
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
    pod 'KIF'
    pod 'KIF/IdentifierTests'
    
    post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
      end
    end

  end

end
