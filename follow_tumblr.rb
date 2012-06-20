gem 'oauth'
require 'oauth'
require 'oauth/consumer'

# Instantiate consumer object
puts "Paste in your consumer key:"
consumer_key = gets.chomp
puts "Paste in your secret key:"
secret_key = gets.chomp

@consumer = OAuth::Consumer.new(consumer_key,
                                secret_key,
                                site: "http://www.tumblr.com")
@request_token = @consumer.get_request_token

puts "Go here to authorize your app:"
puts @request_token.authorize_url      # outputs a url that authorizes the app

puts "\nPaste url from post authorization:"
url = gets

oauth_verifier = url.match(/oauth_verifier=(.+)\n/)[1]

# If we don't yet have an access token, we need to go through the
# OAuth redirect and copy the oauth_verifier from the URL
# We can then use the method below to trade our oauth_verifier for
# and access token.  Be careful, oauth_verifiers expire on the order of
# minutes

@access_token = @request_token.get_access_token(:oauth_verifier => oauth_verifier)

puts <<-EOF
  +-----------------------------------+
  | Paste this code in to get started |
  +-----------------------------------+

  @consumer = OAuth::Consumer.new("#{consumer_key}",
                                  "#{secret_key}",
                                  site: "http://www.tumblr.com")


  OAUTH_TOKEN  = '#{@access_token.token}'
  OAUTH_SECRET = '#{@access_token.secret}'

  access_token = OAuth::AccessToken.new(@consumer, OAUTH_TOKEN, OAUTH_SECRET)
EOF



# Can now do whatever we need to
# access_token has all the normal http request methods
# and returns a standard ruby http response

#### Tumblr API
# All API requests start with api.tumblr.com
#
# To get blog data or write to a blog:
# api.tumblr.com/v2/blog/#{base-hostname}/...
# Example
# api.tumblr.com/v2/blog/#{base-hostname}/posts[/type]
#
# To get user data or perform user actions
# api.tumblr.com/v2/user/...
#
#
# /info — Retrieve Blog Info
# /avatar response is a string url
# /followers
# /posts