#
#  Be sure to run `pod spec lint XLUIKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "XLUIKit"
s.version      = "0.0.2"
s.summary      = "The function extension of the common system UI object is organized in the form of catogry, which is convenient to use."
s.homepage     = "https://github.com/JesseRom/XLUIKit"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "JesseRom" => "lhdaily@163.com" }
s.source       = { :git => "https://github.com/JesseRom/XLUIKit.git", :tag => "#{s.version}" }
s.platform     = :ios, "8.0"
s.requires_arc = true
s.source_files  = "XLUIKit/Classes/**/*"
s.resource_bundles = {
'XLUIKit' => ['XLUIKit/Resource/*']
}
s.frameworks = "Foundation", "UIKit"
s.dependency 'SDWebImage', '~> 3.8.0'
s.dependency 'XLFoundation'

end
