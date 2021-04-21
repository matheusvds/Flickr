platform :ios, '13.1'
use_frameworks!

target 'Flickr' do
end

target 'Application' do
  pod 'SDWebImage', '~> 5.0'

  target 'ApplicationTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          
        end
    end
end
