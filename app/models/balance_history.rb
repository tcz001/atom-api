class BalanceHistory < ActiveRecord::Base
  belongs_to :user
  before_create :generate_serial_number
  private
  def generate_serial_number
    self.serial_number = 'BH' + Base64.encode64(SecureRandom.uuid).slice(0,5) + Time.now.strftime("%y%m%d%H%M%S")
  end
end
