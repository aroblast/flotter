Pod::Spec.new do |s|
  s.name             = 'flotter'
  s.version          = '0.1.0'
  s.summary          = 'Use Lottie animations on iOS.'
  s.description      = <<-DESC
A new flutter plugin project.
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

