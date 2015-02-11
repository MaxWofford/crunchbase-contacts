require 'httparty'

# This should be an array of API keys because crunchbase rate limits a ton
FOUND_CRUNCHBASE_KEY=['cake','pie','sandwich']

# Open our file and iterate through each line
File.readlines('paths.txt').each do |line|
  base_url = "https://api.crunchbase.com/v/2/organization/#{line}"
  params = {
      user_key: FOUND_CRUNCHBASE_KEY[rand(FOUND_CRUNCHBASE_KEY.length)]
  }
  response = HTTParty.get(base_url, query: params)
  json = JSON.parse(response.body)
  # Get email from the response
  # Protect from when the email field doesn't exist
  result = json["data"]["properties"] && json["data"]["properties"]["email_address"]
  unless result == ''
    # Put our result on a new line
    open('emails.txt','a') do |f|
      f.puts "#{result}\n"
    end
  end
  # Be polite to the server
  sleep(rand(3))
end

