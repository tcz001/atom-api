module API
  module Formatter
    def self.normal
      lambda { |object, env|
        {:meta => {status: :ok, msg: ""}, :data => object}.to_json
      }
    end

    def self.error
      lambda { |message, backtrace, options, env|
        {:meta => {status: message[:status], msg: message[:msg]}}.to_json
      }
    end
  end
end
