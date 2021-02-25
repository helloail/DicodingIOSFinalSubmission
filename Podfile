# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!


source 'https://github.com/helloail/DicodingIosExpert-CorePodSpec'
source 'https://github.com/CocoaPods/Specs.git'

workspace 'ForYouDicodingIOSExpertSub1'

target 'ForYouDicodingIOSExpertSub1' do
  # Pods for ForYouDicodingIOSExpertSub1
  pod 'Alamofire', '~> 5.2'
  pod 'SDWebImageSwiftUI'
  pod 'RealmSwift'
  pod 'Core'
  
  post_install do |installer|
          installer.pods_project.targets.each do |target|
              target.build_configurations.each do |config|
                 if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
                   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
                 end
              end
          end
       end
end

target 'Tourism' do
  # Pods for Common
  project 'Modules/Tourism/Tourism'
  pod 'RealmSwift'
  pod 'Alamofire', '~> 5.2'
  pod 'Core'
end
