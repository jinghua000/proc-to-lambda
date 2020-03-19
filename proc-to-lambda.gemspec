lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/proc-to-lambda'

Gem::Specification.new do |s|

  s.name = 'proc-to-lambda'
  s.version = ProcToLambda::VERSION
  s.summary = 'Convert proc to lambda, retain the context.'
  s.description = 'Convert proc to lambda, retain the context.'
  s.authors = ['shadow']
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/jinghua000/proc-to-lambda'
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.1'

end