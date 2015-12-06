class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :lease_orders
  has_many :images, as: :imageable

  def avatar
    ApplicationController.helpers.qiniu_image_path(images.last.file.url, :thumbnail => '50x50', :quality => 80) if self.images.present?
  end
end
