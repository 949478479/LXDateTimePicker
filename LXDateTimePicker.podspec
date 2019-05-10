Pod::Spec.new do |s|
  s.name             = 'LXDateTimePicker'
  s.version          = '0.1.0'
  s.summary          = '支持【年】、【月】、【年月】、【年月日】、【时分】、【年月日时分】的日期选择器'

  s.homepage         = 'https://github.com/949478479/LXDateTimePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '吕小怼' => '949478479@qq.com' }
  s.source           = { :git => 'https://github.com/949478479/LXDateTimePicker.git', :tag => s.version.to_s }

  s.swift_versions = ['4.0', '4.2', '5.0']
  s.ios.deployment_target = '8.0'

  s.source_files = 'LXDateTimePicker/Classes/**/*'
end
