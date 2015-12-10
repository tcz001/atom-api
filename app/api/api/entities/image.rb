module API
  module Entities
    class Image < Grape::Entity
      expose :name
      expose :image_file_url, as: :image_url
      expose :imageable_type
      expose :imageable_id
      expose :file_file_size
      expose :file_updated_at
    end
  end
end
