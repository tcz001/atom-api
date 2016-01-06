class Game < ActiveRecord::Base
  belongs_to :game_version
  belongs_to :game_type
  has_many :images, as: :imageable
  def display_game_type
    self.game_type.name if self.game_type.present?
  end
  def cover
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '500x500', :quality => 80) if self.images.present?
  end
  def cover_small
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '250x250', :quality => 50) if self.images.present?
  end
end
