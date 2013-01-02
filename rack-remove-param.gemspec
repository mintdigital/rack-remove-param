Gem::Specification.new do |gem|
  gem.authors       = ["Thomas Pomfret"]
  gem.email         = ['thomas@mintdigital.com']
  gem.description   = %q{Remove POST params from reqs}
  gem.summary       = %q{Filter out unwanted params}
  gem.homepage      = "http://github.com/mintdigital/rack-remove-param"

  gem.files         = ['lib/rack-remove-param.rb', 'lib/rack/remove-param.rb']
  gem.name          = "rack-remove-param"
  gem.version       = '0.0.4'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rack'
end
