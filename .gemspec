Gem::Specification.new do |s|
  s.name        = 'droptoflare'
  s.version     = '0.0.1'
  s.author      = 'Johan Haals'
  s.email       = 'johan@haals.se'
  s.homepage    = 'https://github.com/jhaals/droptoflare'
  s.summary     = 'Populate Cloudflare DNS with DigitalOcean droplets'
  s.license     = 'Apache 2.0'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib', 'bin']
  s.executables   = 'droptoflare'
  s.add_runtime_dependency 'httparty'
end

