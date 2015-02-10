require 'httparty'
require 'byebug'

LA='4ce61f42f6c4e7ec798d44813b58856b'

# file = File.write("paths.txt")

base_url = 'https://api.crunchbase.com/v/2/organizations'
params = {
    location_uuids: LA,
    user_key: FOUND_CRUNCHBASE_KEY,
    page: i
}
response = HTTParty.get(base_url, query: params)
json = JSON.parse(response.body)
organizations = json["data"]["items"]
paths = []

organizations.each do |organization|
    path = organization["path"]
    
    paths << path.gsub('organization/','')
    puts path
    if organization == organizations.last
        paths = paths.uniq
        open("paths.txt", 'a') do |f|
            f.puts paths
        end
    end
end
# byebug`





# puts response.body, response.code, response.message, response.headers.inspect
