# https://guides.rubygems.org/specification-reference/

Gem::Specification.new do |s|

  s.name        = 'requesta'
  s.version     = '0.1.3'
  s.summary     = "A wrapper for simple http requests, in Ruby."
  s.description = "A wrapper for simple http requests, in Ruby."
  s.authors     = ["Edrick Clark"]
  s.email       = 'edrickclark@gmail.com'
  s.homepage    = 'https://github.com/edrickclark/requesta'
  
  s.files       = Dir['lib/**/*', 'requesta.gemspec']
  
  s.metadata    = {
                    "source_code_uri" => "https://github.com/edrickclark/requesta"
                  }

  s.required_ruby_version = '>= 2.2.2'

  s.add_runtime_dependency 'activesupport', '~> 5.2'
  s.add_development_dependency 'awesome_print', '~> 1.8'
  s.add_development_dependency 'rspec', '~> 3.7'

end