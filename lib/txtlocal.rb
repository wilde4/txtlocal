require 'txtlocal/config'
require 'txtlocal/message'
require 'txtlocal/credit'

module Txtlocal
  class << self

    def config
      @config ||= Config.new
      if block_given?
        yield @config
      end
      @config
    end

    def reset_config
      @config = nil
    end

    def send_message(message, recipients, options={})
      msg = Txtlocal::Message.new(message, recipients, options)
      msg.send!
      msg
    end

    def check_credit
      credit_check = Txtlocal::Credit.new
      credit_check.send!
      credit_check
    end

  end
end
