#
# Be sure to run `pod lib lint ZQLStarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZQLStarView"
  s.version          = "0.0.1"
  s.summary          = "A star view to give something a mark"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "A star view to give something a mark,hope you like it"

  s.homepage         = "https://github.com/zangqilong198812/ZQLStarView"
  s.screenshots     = "http://7xi4jm.com1.z0.glb.clouddn.com/starview.gif"
  s.license          = 'MIT'
  s.author           = { "zangqilong" => "zangqilong@gmail.com" }
  s.source           = { :git => "https://github.com/zangqilong198812/ZQLStarView.git", :tag => "0.0.1" }
  s.social_media_url = 'http://weibo.com/1438670852/profile?rightmod=1&wvr=6&mod=personinfo&is_all=1'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ZQLStarView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
