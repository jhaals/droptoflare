require 'droptoflare/cloudflare'
require 'rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.describe 'Cloudflare' do
  it 'should raise NameError' do
    expect { Cloudflare.new }.to raise_error(ArgumentError)
  end

  cf = Cloudflare.new('access_token', 'pyp.se', 'johan@haals.se')
  it 'should complain about invalid token or email' do
    VCR.use_cassette('cf_invalid_token', serialize_with: :json) do
      expect { cf.records }.to raise_error(RuntimeError, 'Invalid token or email')
    end
  end

  it 'should list records' do
    VCR.use_cassette('cf_records', serialize_with: :json) do
      expect(cf.records).to include('d1.pyp.se' => { ip: '178.62.36.22', id: '170347876' })
    end
  end
end
