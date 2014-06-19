require 'faraday'
require_relative '../judopay/error'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        body = JSON.parse(response.body)
        errorType = body['errorType'].to_i # Can provide additional information
        case response.status.to_i
        when 400
          raise Judopay::BadRequest, error_message_400(response)
        when 401
        when 403
          raise Judopay::NotAuthorized, error_message_500(response, 'Check your login credentials and permissions') # Improve this message
        when 404
          raise Judopay::NotFound, error_message_400(response)
        when 409
          raise Judopay::Conflict, error_message_400(response)
        when 500
          raise Judopay::InternalServerError, error_message_500(response, "Something is technically wrong.")
        when 502
          raise Judopay::BadGateway, error_message_500(response, "The server returned an invalid or incomplete response.")
        when 503
          raise Judopay::ServiceUnavailable, error_message_500(response, "Judopay is rate limiting your requests.")
        when 504
          raise Judopay::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{response.body}"
    end

    def error_body(body)
      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        # removed multi_json thanks to wesnolte's commit
        body = ::JSON.parse(body)
      end

      if body.nil?
        nil
      elsif body['meta'] and body['meta']['error_message'] and not body['meta']['error_message'].empty?
        ": #{body['meta']['error_message']}"
      elsif body['error_message'] and not body['error_message'].empty?
        ": #{body['error_type']}: #{body['error_message']}"
      end
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end