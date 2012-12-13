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

  # Specify the location from where the source should be retreived.
  #
  s.source   = { :git => 'https://github.com/azu/AAMFeedback.git' }
  # s.source   = { :svn => 'http://EXAMPLE/AAMFeedback/tags/1.0.0' }
  # s.source   = { :hg  => 'http://EXAMPLE/AAMFeedback', :revision => '1.0.0' }

  #s.description = 'An optional longer description of AAMFeedback.'

  # If this Pod runs only on iOS or OS X, then specify that with one of
  # these, or none if it runs on both platforms.
  #
  s.platform = :ios
  # s.platform = :osx

  # A list of file patterns which select the source files that should be
  # added to the Pods project. If the pattern is a directory then the
  # path will automatically have '*.{h,m,mm,c,cpp}' appended.
  #
  # Alternatively, you can use the FileList class for even more control
  # over the selected files.
  # (See http://rake.rubyforge.org/classes/Rake/FileList.html.)
  #
  s.source_files = 'AAMFeedback/AAMFeedback/*.{h,m}'

  # A list of resources included with the Pod. These are copied into the
  # target bundle with a build phase script.
  #
  # Also allows the use of the FileList class like `source_files does.
  #
  s.resources = 'AAMFeedback/AAMFeedback/AAMLocalizable/*'

  # A list of paths to remove after installing the Pod without the
  # `--no-clean' option. These can be examples, docs, and any other type
  # of files that are not needed to build the Pod.
  #
  # *NOTE*: Never remove license and README files.
  #
  # Also allows the use of the FileList class like `source_files does.
  #
  # s.clean_path = "examples"
  # s.clean_paths = "examples", "doc"

  # Specify a list of frameworks that the application needs to link
  # against for this Pod to work.
  #
  s.framework = 'MessageUI'

  s.dependency 'UIDeviceIdentifier'
end
