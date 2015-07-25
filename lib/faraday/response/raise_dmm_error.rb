# encoding: utf-8
require 'faraday'

module Faraday
  class Response
    class RaiseDMMError < Middleware
      ERROR_MAP = {
        400 => DMM::BadRequest,
        401 => DMM::Unauthorized,
        403 => DMM::Forbidden,
        404 => DMM::NotFound,
        406 => DMM::NotAcceptable,
        422 => DMM::UnprocessableEntity,
        500 => DMM::InternalServerError,
        501 => DMM::NotImplemented,
        502 => DMM::BadGateway,
        503 => DMM::ServiceUnavailable
      }

      def on_complete(response)
        key = response[:status].to_i
        raise ERROR_MAP[key], response if ERROR_MAP.key? key
      end
    end
  end
end
