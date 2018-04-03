

Pod::Spec.new do |s|
  s.name             = 'YMLSegmentControl'
  s.version          = '1.0.0'
  s.summary          = 'YMLSegmentControl'

  s.description      = <<-DESC
                        'A simple and easy to use segment control.'
                       DESC

  s.homepage         = 'http://huberyyang.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HuberyYang' => 'yml_hubery@sina.com' }
  s.source           = { :git => 'https://github.com/HuberyYang/YMLSegmentControl.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'YMLSegmentControl/Classes/**/*'
  s.frameworks = 'UIKit'

end
