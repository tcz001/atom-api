require 'SecureRandom'
class LeaseOrder < ActiveRecord::Base
  belongs_to :user
  has_many :accounts
  before_create :generate_serial_number

  @@i18n = {
      status: {
          0 => '等待确认',
          1 => '拒绝',
          2 => '待支付',
          3 => '使用中',
          4 => '已过期',
          5 => '已结束',
      },
  }

  def display_status
    @@i18n[:status][self.status]
  end

  private
  def generate_serial_number
    self.serial_number = SecureRandom.uuid.gsub(/-/, '').to_i(16)
  end
end
