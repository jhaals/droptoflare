require 'httparty'
require 'json'

# list DigitalOcean Droplets
class DigitalOcean
  def initialize(token)
    @token = token
  end

  # Return hash with droplets: droplet_name => ipaddress
  def droplets
    response = HTTParty.get(
      'https://api.digitalocean.com/v2/droplets',
      headers: { 'Authorization' => "Bearer #{@token}" })
    r = JSON.parse(response.body)
    fail r['message'] if response.code != 200

    droplets = {}
    r['droplets'].each do |e|
      e['networks']['v4'].each do |i|
        next if i['type'] == 'private'
        droplets[e['name']] = i['ip_address']
      end
    end
    droplets
  end
end
