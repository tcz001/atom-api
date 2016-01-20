class Game < ActiveRecord::Base
  belongs_to :game_version
  belongs_to :game_type
  has_many :images, as: :imageable
  @@i18n = {
      language: {
          '简' => '简体中文',
          '繁' => '繁体中文',
          '日' => '日文',
          '英' => '英文',
      },
  }

  def display_game_type
    self.game_type.name if self.game_type.present?
  end
  def display_language
    self.language.split(',').map { |l| @@i18n[:language][l] }.join(',')
  end
  def cover
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '500x500', :quality => 80) if self.images.present?
  end
  def cover_small
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '250x250', :quality => 50) if self.images.present?
  end
end
