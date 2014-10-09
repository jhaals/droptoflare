require 'json'
require 'httparty'

class Cloudflare
  def initialize(cf_token, domain, email)
    @cf_token = cf_token
    @domain = domain
    @email = email
  end

  def create_record(name, ip)
    options = {
      body: {
        a: 'rec_new',
        tkn: @cf_token,
        email: @email,
        z: @domain,
        name: name,
        content: ip,
        type: 'A',
        ttl: 120
      }
    }
    r = JSON.parse(
      HTTParty.post('https://www.cloudflare.com/api_json.html', options).body)
    if r['result'] == 'error'
      puts r['msg']
      return false
    end
    return true if r['result'] == 'success'
  end

  def records
    entries = {}
    options = {
      body: {
        a: 'rec_load_all',
        tkn: @cf_token,
        email: @email,
        z: @domain
      }
    }
    r = JSON.parse(
      HTTParty.post('https://www.cloudflare.com/api_json.html', options).body)
    r['response']['recs']['objs'].each do |e|
      next if e['type'] != 'A'
      entries[e['name']] = { ip: e['content'], id: e['rec_id'] }
    end
    entries
  end

  def update_record(name, ip, id)
    options = {
      body: {
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
    }
    r = JSON.parse(
      HTTParty.post('https://www.cloudflare.com/api_json.html', options).body)
    if r['result'] == 'error'
      puts r['msg']
      return false
    end
    return true if r['result'] == 'success'
  end
end
