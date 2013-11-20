require 'net/https'
require 'uri'
require 'json'

module Txtlocal
  class Credit

    attr_accessor :response

    def initialize
    end
    
    def response=(response)
      if not response.body.empty?
        @response = {}
        data = JSON.parse(response.body)
        data.each_pair do |k, v|
          key = k.gsub(/\B[A-Z]+/, '_\0').downcase.to_sym
          @response[key] = v
        end
      end
    end

    API_ENDPOINT = URI.parse("https://www.txtlocal.com/getcredits.php")
    def send!
      http = Net::HTTP.new(API_ENDPOINT.host, API_ENDPOINT.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(API_ENDPOINT.path)
      req.set_form_data(:json => 1,
                        :uname => Txtlocal.config.username,
                        :pword => Txtlocal.config.password)
      result = http.start { |http| http.request(req) }
      self.response = result
    end
  end
end
