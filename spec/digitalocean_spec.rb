require 'droptoflare/digitalocean'
require 'rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.describe 'DigitalOcean' do
  it 'should raise NameError' do
    expect { Digitalocean.new }.to raise_error(NameError)
  end

  it 'should complain about invalid token' do
    VCR.use_cassette('do_invalid_token', serialize_with: :json) do
      digitalocean = DigitalOcean.new('t00ken')
      expect { digitalocean.droplets }.to raise_error(RuntimeError, 'Unable to authenticate you.')
    end
  end
  it 'should return hash of droplets' do
    VCR.use_cassette('do_droplets', serialize_with: :json) do
      digitalocean = DigitalOcean.new('valid_token')
      droplets = digitalocean.droplets
      expect(droplets).to include('d1' => '178.62.36.22')
      expect(droplets).to include('t1' => '178.62.20.222')
    end
  end
end
