require 'json'
require 'net/http'
require 'uri'

# methods to create/update/list Cloudflare A records
class Cloudflare
  def initialize(cf_token, domain, email)
    @cf_token = cf_token
    @domain = domain
    @email = email
  end

  # Create new A record
  def create_record(name, ip)
    data = {
      a: 'rec_new',
      tkn: @cf_token,
      email: @email,
      z: @domain,
      name: name,
      content: ip,
      type: 'A',
      ttl: 120
    }
    query(data)
  end

  # Return hash with all A records for domain
  def records
    entries = {}
    data = {
      a: 'rec_load_all',
      tkn: @cf_token,
      email: @email,
      z: @domain
    }
    r = query(data)
    r['response']['recs']['objs'].each do |e|
      next if e['type'] != 'A'
      entries[e['name']] = { ip: e['content'], id: e['rec_id'] }
    end
    entries
  end

  # Update existing record
  def update_record(name, ip, id)
    data = {
      a: 'rec_edit',
      tkn: @cf_token,
      email: @email,
      z: @domain,
      name: name,
      content: ip,
      id: id,
      type: 'A',
      ttl: 120
    }
    query(data)
  end

  private

  def query(data)
    uri = URI.parse('https://www.cloudflare.com/api_json.html')
    resp = Net::HTTP.post_form(uri, data)
    r = JSON.parse(resp.body)
    fail r['msg'] if r['result'] != 'success'
    r
  end
end
