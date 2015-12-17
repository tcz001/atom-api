class Game < ActiveRecord::Base
  belongs_to :game_version
  belongs_to :game_type
  has_many :images, as: :imageable
  def display_game_type
    self.game_type.name
  end
  @@i18n = {
      language: {
          0 => '英文版',
          1 => '日文版',
          2 => '中文版',
          3 => '香港繁体版',
      },
      version: {
          0 => '港版',
          1 => '美版',
          2 => '日版',
          3 => '国行',
      },
  }
  def display_language
    @@i18n[:language][self.game_version.language]
  end
  def display_version
    @@i18n[:version][self.game_version.version]
  end
  def cover
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '150x150', :quality => 80) if self.images.present?
  end
  def cover_small
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '80x80', :quality => 50) if self.images.present?
  end
end
