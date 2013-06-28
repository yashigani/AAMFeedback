Pod::Spec.new do |s|
  s.name     = 'AAMFeedback'
  s.version  = '0.0.3'
  s.summary  = 'iOS user feedback component for universal use.'
  s.homepage = 'https://github.com/fladdict/AAMFeedback'
  s.authors  = { 'fladdict' => 'fukatsu@gmail.com', 'azu' => 'azuciao@gmail.com' }
  s.license  = { :type => 'BSD', :file => 'LICENSE' }
  s.source   = { :git => 'https://github.com/azu/AAMFeedback.git' }
  s.platform = :ios
  s.source_files = 'AAMFeedback/AAMFeedback/*.{h,m}'
  s.resources = 'AAMFeedback/AAMFeedback/*.lproj'
  s.framework = 'MessageUI'
  s.dependency 'UIDeviceIdentifier'
  s.requires_arc = true
end
