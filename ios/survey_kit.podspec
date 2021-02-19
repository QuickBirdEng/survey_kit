#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint surveykit.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'survey_kit'
  s.version          = '0.0.1'
  s.summary          = 'A flutter plugin to create nice surveys.'
  s.description      = <<-DESC
A plugin to create nice surveys.
                       DESC
  s.homepage         = 'https://www.quickbirdstudios.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'QuickBird Studios GmbH' => 'info@quickbirdstudios.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
