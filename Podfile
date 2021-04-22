DEPLOYMENT_VERSION = '13.1'.freeze
DEPLOYMENT_TARGET_KEY = 'IPHONEOS_DEPLOYMENT_TARGET'.freeze
PODS_MIN_DEPLOYMENT_VERSION = '13.1'.freeze
platform :ios, DEPLOYMENT_VERSION
use_frameworks!

target 'Flickr' do
end

target 'Application' do
  pod 'SDWebImage', '5.11.0'

  target 'ApplicationTests' do
    inherit! :none
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings[DEPLOYMENT_TARGET_KEY].to_f < PODS_MIN_DEPLOYMENT_VERSION.to_f
                config.build_settings[DEPLOYMENT_TARGET_KEY] = PODS_MIN_DEPLOYMENT_VERSION
                puts "Successfully set #{DEPLOYMENT_TARGET_KEY}=#{PODS_MIN_DEPLOYMENT_VERSION} on #{target.name} '#{config.display_name}'"
            end
        end
    end
end
