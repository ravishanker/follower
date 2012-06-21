require 'rubygems'
require "bundler/setup"
require 'oauth'
require 'oauth/consumer'
require 'json'
require 'highline'
require 'launchy'

# 1. Register at https://dev.twitter.com/apps
# 2. Get your Consumer key and Consumer secret
# Take note of (a) Request token URL, (b) Authorize URL, (c) Access token URL and (d) Callback URL if a webapp

CONSUMER_KEY = "o3GjbYHzTWUCQmp9AfknA"
CONSUMER_SECRET = "1oWlK5iAlB1MeFeiDZLzhMUjrjPGwJA4AcpaKRKSo"

# REQUEST_TOKEN_URL = 'https://api.twitter.com/oauth/request_token'
# AUTHORIZE_URL = 'https://api.twitter.com/oauth/authorize'
# ACCESS_TOKEN_URL = 'https://api.twitter.com/oauth/access_token'

# You could generate your access tokens and hard code them for single personal user if you wish

# ACCESS_TOKEN = "18439287-7D0YgvIetWW8lthh0P3TEgZcHWgw4ax4fbbGdeCBw"
# ACCESS_TOKEN_SECRET = "aU2wlekq6BIxG3rTeGHJxNC4dpI6AwAL1OhfVQWurI"

# initialize the oauth object

oauth = OAuth::Consumer.new(CONSUMER_KEY,
                CONSUMER_SECRET,
                { :site => "https://twitter.com",
                  :request_token_path => '/oauth/request_token',
                  :access_token_path => '/oauth/access_token',
                  :authorize_path => '/oauth/authorize' })

# Ask for a token to make a request
#url = "http://socrates.devbootcamp.com"
request_token = oauth.get_request_token()

# Save token and secret for use later
#token = request_token.token
#secret = request_token.secret

puts "Request Token: #{request_token.token} \n Request Secret: #{request_token.secret}"



# Send the user to Twitter to be authenticated
Launchy.open( request_token.authorize_url)
highline = HighLine.new()
oauth_pin = highline.ask("Please enter the PIN you got from authorization: ")
puts "OAuth Verifier PIN : #{oauth_pin}"

# Construct access request using token and secret
#request_token = OAuth::RequestToken.new(oauth, token, secret)

#puts request_token

access_token = request_token.get_access_token( :oauth_verifier => oauth_pin )

puts access_token

#puts access_token.get('/account/verify_credentials.json')

#response = access_token.request(:get, "http://api.twitter.com/1/statuses/home_timeline.json")

user = access_token.request(:post, "https://api.twitter.com/1/friendships/create.json", {:screen_name => 'lifmus'})



#puts user.inspect()
follow_user = JSON.parse(user.body)

follow_user.each { |key, value| puts "#{key} : #{value}"}

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
