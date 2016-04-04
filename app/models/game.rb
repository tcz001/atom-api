class Game < ActiveRecord::Base
  has_many :game_skus
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
  scope :published, -> { where(is_valid: true) }

  def display_game_type
    self.game_type.name if self.game_type.present?
  end
  def display_language
    self.language.split(',').map { |l| @@i18n[:language][l] }.join(',') if self.language.present?
  end
  def display_reference_price
    sorted_prices = self.game_skus_published.sort_by{|e| e[:price]}
    sorted_prices.first.price if sorted_prices.present?
  end
  def price_range
    if self.game_skus.present?
      sorted_prices = self.game_skus_published.sort_by{|e| e[:price]}
      return "#{sorted_prices.first.price}-#{sorted_prices.last.price}"
    end
  end
  def game_skus_published
    game_skus.published
  end
  def cover
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '500x500', :quality => 80) if self.images.present?
  end
  def cover_small
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '250x250', :quality => 50) if self.images.present?
  end
end
