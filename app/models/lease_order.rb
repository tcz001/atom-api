require 'securerandom'
class LeaseOrder < ActiveRecord::Base
  belongs_to :user
  has_many :accounts
  has_many :charges
  before_create :generate_serial_number

  @@limit = {
      grade: {
          -1 => 0,
          0 => 0,
          1 => 1,
          2 => 2,
          3 => 3,
          4 => 4,
      },
  }

  @@i18n = {
      status: {
          0 => '待确认',
          1 => '已拒绝',
          2 => '待支付',
          3 => '使用中',
          4 => '已过期',
          5 => '已结束',
          6 => '已取消',
      },
  }

  def self.limit_by_grade(grade)
    @@limit[:grade][grade]
  end

  def display_status
    @@i18n[:status][self.status]
  end

  private
  def generate_serial_number
    self.serial_number = Base64.encode64(SecureRandom.uuid).slice(0,5) + Time.now.strftime("%y%m%d%H%M%S")
  end
end
