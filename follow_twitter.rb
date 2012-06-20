gem 'oauth'
require 'oauth'
require 'oauth/consumer'
require 'json'
require 'highline'
require 'launchy'

CONSUMER_KEY = "o3GjbYHzTWUCQmp9AfknA"
CONSUMER_SECRET = "1oWlK5iAlB1MeFeiDZLzhMUjrjPGwJA4AcpaKRKSo"

# REQUEST_TOKEN_URL = 'https://api.twitter.com/oauth/request_token'
# AUTHORIZE_URL = 'https://api.twitter.com/oauth/authorize'
# ACCESS_TOKEN_URL = 'https://api.twitter.com/oauth/access_token'
#
# ACCESS_TOKEN = "18439287-7D0YgvIetWW8lthh0P3TEgZcHWgw4ax4fbbGdeCBw"
# ACCESS_TOKEN_SECRET = "aU2wlekq6BIxG3rTeGHJxNC4dpI6AwAL1OhfVQWurI"


oauth = OAuth::Consumer.new(CONSUMER_KEY,
                CONSUMER_SECRET,
                { :site => "http://twitter.com",
                  :request_token_path => '/oauth/request_token',
                  :access_token_path => '/oauth/access_token',
                  :authorize_path => '/oauth/authorize' })

# Ask for a token to make a request
url = "http://socrates.devbootcamp.com"
request_token = oauth.get_request_token()

# Save token and secret for use later
token = request_token.token
secret = request_token.secret

# Send the user to Twitter to be authenticated
Launchy.open( request_token.authorize_url)
highline = HighLine.new()
oauth_pin = highline.ask("Please enter the PIN you got from authorization: ")

# Construct access request using token and secret
request_token = OAuth::RequestToken.new(oauth, token, secret)

access_token = request_token.get_access_token( :oauth_verifier => oauth_pin )

puts access_token.get('/account/verify_credentials.json')

#user = access_token.request(:post, "http://api.twitter.com/1/friendships/create.json",{:screen_name => "lifmus"})
user = access_token.request(:post, "https://api.twitter.com/1/friendships/create.json", {:screen_name => 'lifmus'})

#response = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json")

# puts user_info = JSON.parse(response.body)
puts user.inspect()
puts JSON.parse(user.body)

# Single user OAuth by exchanging token and secret for an AccessToken instance

# def prepare_access_token(oauth_token, oauth_token_secret)
#   consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET,
#     { :site => "http://api.twitter.com", :scheme => :header
#     })
#
#     token_hash = { :oauth_token => oauth_token,
#                    :oauth_token_secret => oauth_token_secret
#                   }
#
#     access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
#     return access_token
# end

#access_token = prepare_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

#POST to http://twitter.com/statuses/update.json



#response = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json")

#screen_names = @client.followers.collect{|follower| follower.screen_name}

#info = JSON.parse(response.body)

#puts info
