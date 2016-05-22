module API
  module Entities
    class UrlBind < Grape::Entity
      expose :code
      expose :url
    end
  end
end
