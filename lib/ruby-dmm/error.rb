# encoding: utf-8
module DMM
  Error               = Class.new(StandardError)
  BadRequest          = Class.new(Error)
  Unauthorized        = Class.new(Error)
  Forbidden           = Class.new(Error)
  NotFound            = Class.new(Error)
  NotAcceptable       = Class.new(Error)
  UnprocessableEntity = Class.new(Error)
  InternalServerError = Class.new(Error)
  NotImplemented      = Class.new(Error)
  BadGateway          = Class.new(Error)
  ServiceUnavailable  = Class.new(Error)
end
