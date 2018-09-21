# FILE: lib/requesta.rb

# Reference:
# https://guides.rubyonrails.org/active_support_core_extensions.html

require 'net/http'
require 'net/https'
require 'active_support'
require 'active_support/core_ext/object/blank'

require_relative 'requesta/errors'

class Requesta

  attr_accessor :ssl, :post, :verbose, :body
  attr_writer :username, :password
  attr_reader :headers

  def initialize
    @ssl = false
    @post = false
    @verbose = true
    @headers = {}
  end

  def request(uri)
    unless uri.is_a?(URI)
      raise RequestaError::RequestError, "request(): 'uri' parameter must be of type 'URI'"
    end

    puts "Requesting '#{uri.to_s}'" if @verbose

    http = Net::HTTP.new(uri.host, uri.port)

    if @ssl || uri_scheme_https?(uri)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    request = @post ? Net::HTTP::Post.new(uri) : Net::HTTP::Get.new(uri)

    if @username.present? && @password.present?
      request.basic_auth(@username, @password)
    end
    
    if @headers.present?
      @headers.each{ |key, value| request.add_field(key, value) }
    end
    
    if @body.present?
      request.body = @body
    end

    http.request(request)
  end

  # Request Headers
  #-----------------

  def set_headers(headers)
    unless headers.is_a?(Hash)
      raise RequestaError::RequestHeaderError, "set_headers(): 'headers' parameter must be of type 'Hash'"
    end

    headers.each{ |key,value| set_header(key, value) }
  end

  def set_header(key, value)
    unless key.is_a?(String) || key.is_a?(Symbol)
      raise RequestaError::RequestHeaderError, "set_header(): 'key' parameter must be of type Symbol or String"
    end

    unless value.is_a?(String) || value.is_a?(Symbol)
      raise RequestaError::RequestHeaderError, "set_header(): 'value' parameter must be of type Symbol or String"
    end

    @headers[key] = value
  end

  def clear_headers
    @headers = {}
  end

  def clear_header(key)
    unless key.is_a?(String) || key.is_a?(Symbol)
      raise RequestaError::RequestHeaderError, "clear_header(): 'key' must be of type Symbol or String"
    end

    @headers.delete(key)
  end

private

  # URI/HREF
  #----------

  def uri_scheme_https?(uri)
    unless uri.is_a?(URI)
      raise RequestaError::MethodError, "href_scheme_https?(): 'href' parameter must be of type 'URI'"
    end

    uri.scheme == 'https'
  end

  def href_scheme_https?(href)
    unless href.is_a?(String)
      raise RequestaError::MethodError, "href_scheme_https?(): 'href' parameter must be of type 'String'"
    end

    uri = URI(href)
    uri_scheme_https?(uri)
  end

end