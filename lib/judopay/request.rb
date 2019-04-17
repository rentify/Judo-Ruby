require 'openssl'
require 'json'

module Judopay
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options = {}, raw = false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options = {}, raw = false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, options = {}, raw = false)
      request(:put, path, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, options = {}, raw = false)
      request(:delete, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw = false)
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          unless options.nil?
            request.body = Judopay::Serializer.new(options).as_json
            Judopay.log(Logger::DEBUG, 'Request body: ' + request.body)
          end
        end
      end

      Judopay.log(Logger::DEBUG, response)
      return response if raw

      Response.create(response.body)
    end
  end
end
