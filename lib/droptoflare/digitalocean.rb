require 'net/http'
require 'uri'
require 'json'

# list DigitalOcean Droplets
class DigitalOcean
  def initialize(token)
    @token = token
  end

  # Return hash with droplets: droplet_name => ipaddress
  def droplets
    uri = URI.parse('https://api.digitalocean.com/v2/droplets')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field('Authorization', "Bearer #{@token}")

    response = http.request(req)
    r = JSON.parse(response.body)
    fail r['message'] if response.code != '200'

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
