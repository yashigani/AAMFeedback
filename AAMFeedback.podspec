#
# Be sure to run `pod lint AAMFeedback.podspec' to ensure this is a
# valid spec.
#
# Remove all comments before submitting the spec.
#
Pod::Spec.new do |s|
  s.name     = 'AAMFeedback'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'iOS user feedback component for universal use.'
  s.homepage = 'https://github.com/fladdict/AAMFeedback'
  s.author   = { 'fladdict' => 'fukatsu@gmail.com' }
  s.source   = { :git => 'https://github.com/azu/AAMFeedback.git' }
  s.platform = :ios
  s.source_files = 'AAMFeedback/AAMFeedback/*.{h,m}'
  s.resources = 'AAMFeedback/AAMFeedback/AAMLocalizable/*'
  s.framework = 'MessageUI'
  s.dependency 'UIDeviceIdentifier'
end
