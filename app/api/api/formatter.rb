module API
  module Formatter
    def self.normal
      lambda { |object, env|
        {:meta => {status: :ok, msg: ""}, :data => object}.to_json
      }
    end

    def self.error
      lambda { |message, backtrace, options, env|
        {:meta => {status: :error, msg: "#{message[:error]}:#{message[:detail]}"}}.to_json
      }
    end
  end
end
