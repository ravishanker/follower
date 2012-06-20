require 'net/https'
require "uri"
require 'oauth'
require 'rexml/document'
require 'yaml'


auth = YAML.load(File.open('auth.yaml'))
#File.open('auth.yaml', 'w') { |f| YAML.dump(auth, f) }

auth = {}

@consumer = OAuth::Consumer.new auth['consumer_key'], auth['consumer_secret'], {:site => ''}
@request_token = @consumer.get_request_token
puts @request_token.authorize_url
verifier = gets.strip
@access_token = @request_token.get_access_token(:oauth_verifier => verifier)
auth['token'] = @access_token
auth['token_secret'] = @access_token.secret


def get_spreadsheet

  request = response = href = ""

  begin
    http = Net::HTTP.new('https://docs.google.com/a/devbootcamp.com/spreadsheet/ccc?key=0AtsLecjMWFCbdEJwNEpRcW5TMU53QV9GX1pPMllfYUE')
    http.use_ssl = true
    http.start do |http|
      request = Net::HTTP::Get.new
      uri = URI.parse('https://docs.google.com/a/devbootcamp.com/spreadsheet/ccc?key=0AtsLecjMWFCbdEJwNEpRcW5TMU53QV9GX1pPMllfYUE')

  Net::HTTP.finish()

  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https').start do |http|

    request = Net::HTTP::Get.new uri.request_uri
    response = http.request request # Net::HTTPResponse object

  end

  puts response.code
  puts response.message
  puts response.class.name

  puts res.body if res.is_a?(Net::HTTPSuccess)



end

get_spreadsheet()

