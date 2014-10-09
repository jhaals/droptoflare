require 'httparty'
require 'json'

class DigitalOcean
  def initialize(token)
    @token = token
  end

  def droplets
    r = HTTParty.get('https://api.digitalocean.com/v2/droplets',
                     headers: { 'Authorization' => "Bearer #{@token}" })
    r = JSON.parse(r.body)
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