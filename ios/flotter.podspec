Pod::Spec.new do |s|
  s.name             = 'flotter'
  s.version          = '0.2.1'
  s.summary          = 'Use Lottie animations on iOS.'
  s.description      = <<-DESC
Flotter is a plugin allowing you to use Lottie AnimationViews inside of Flutter, natively, using PlatformViews.
                       DESC
  s.homepage         = 'https://github.com/aroblast/flotter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bastien LE CORRE' => 'bastien.lecorre@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'lottie-ios'

  s.ios.deployment_target = '12.0'
end

