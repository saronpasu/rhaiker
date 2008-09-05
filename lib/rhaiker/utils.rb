#!ruby -Ku
require 'uri'
require 'net/http'
require 'rexml/document'
require 'time'

class Rhaiker

=begin rdoc
Utility Module for Rhaiker. 
This module include URI, Net::HTTP, REXML::Document, and Time.
=end
  module Utils

=begin rdoc
Description::
  create Net::HTTPRequest instance.

Params::
  type (:post|:get),
  uri URI-Instance,
  use_basic_auth (booleans)

Return::
  Net::HTTPRequest-Instance

RelatedMethods::
  create_uri,
  http_access
=end
    def create_request(type, uri, use_basic_auth = false)
      case type
        when :get
          request = Net::HTTP::Get.new(uri.request_uri)
        when :post
          request = Net::HTTP::Post.new(uri.request_uri)
      end
      request['User-Agent'] = @user_agent
      request.basic_auth @user_id, @api_key if use_basic_auth
      return request
    end

=begin rdoc
Description::
  create URI instance.

Params::
  url_string

Return::
  URI-Instance

RelatedMethods::
  parse_options,
  create_request,
  http_access
=end
    def create_uri(url_string)
      return URI.parse(URI.escape(url_string))
    end

=begin rdoc
Description::
  access to Hatena::Haiku::API[http://h.hatena.ne.jp/api]

Params::
  uri (URI-Instance),
  request (Net::HTTPRequest-Instance)

Return::
  REXML::Document-Instance or false

RelatedMethods::
  create_uri,
  create_request
=end
    def http_access(uri, request)
      Net::HTTP.start(uri.host, uri.port){|http|
        response = http.request(request)
        if response.code == '200'
          return REXML::Document.new(response.body)
        else
          return false
        end
      }
    end

=begin rdoc
Description::
  parse option parametors

Params::
  options ({:param_name => value, [...]})

Return::
  parsed-options ('?param_name=value&...')

RelatedMethods::
  create_uri
=end
    def parse_options(options)
      result = ''
      if options[:since]
        options[:since] = Time.parse(options[:since].to_s).httpdate
      end
      options = options.find_all{|option|option.last}
      result = '?' + options.collect{|option|
        option.join('=')
      }.join('&') unless options.empty?
      return result
    end
  end
end
