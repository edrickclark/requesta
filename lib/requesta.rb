require 'net/http'
require 'net/https'

# https://guides.rubyonrails.org/active_support_core_extensions.html
require 'active_support/all'

require_relative 'requesta/custom_error'

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
    raise CustomError, "request(): URI was nil" if uri.nil?

    puts "Requesting '#{uri.to_s}'" if @verbose

    http = Net::HTTP.new(uri.host, uri.port)

    scheme_is_https = (uri.scheme == 'https')

    if @ssl || scheme_is_https
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
  rescue CustomError => error
    error.report
    nil
  end

  # Request Headers
  #-----------------

  def set_headers(headers={})
    raise CustomError, "set_headers(): headers was blank" if headers.blank?
    headers.each{ |key,value| set_header(key, value) }
  rescue CustomError => error
    error.report
    nil
  end

  def set_header(key=nil, value=nil)
    raise CustomError, "set_header(): key was nil" if key.nil?
    raise CustomError, "set_header(): value was nil" if value.nil?
    @headers[key] = value
  rescue CustomError => error
    error.report
    nil
  end

  def clear_headers
    @headers = {}
  rescue CustomError => error
    error.report
    nil
  end

  def clear_header(key=nil)
    raise CustomError, "clear_header(): key was nil" if key.nil?
    @headers.delete(key)
  rescue CustomError => error
    error.report
    nil
  end

end