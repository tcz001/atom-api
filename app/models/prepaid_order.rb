require 'securerandom'
class PrepaidOrder < ActiveRecord::Base
  belongs_to :user
  has_many :charges
  before_create :generate_serial_number

  @@i18n = {
      status: {
          0 => '待支付',
          1 => '已支付',
      },
  }

  def display_status
    @@i18n[:status][self.status]
  end

  private
  def generate_serial_number
    self.serial_number = 'PO' + Base64.encode64(SecureRandom.uuid).slice(0, 5) + Time.now.strftime("%y%m%d%H%M%S")
  end
end
