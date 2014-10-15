Gem::Specification.new do |s|
  s.name        = 'droptoflare'
  s.version     = '0.0.4'
  s.author      = 'Johan Haals'
  s.email       = 'johan@haals.se'
  s.homepage    = 'https://github.com/jhaals/droptoflare'
  s.summary     = 'Populate Cloudflare DNS with DigitalOcean Droplets'
  s.license     = 'Apache 2.0'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib', 'bin']
  s.executables   = 'droptoflare'
end

