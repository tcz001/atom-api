class LeaseOrder < ActiveRecord::Base
  belongs_to :games
  belongs_to :game_versions
  belongs_to :third_partys

    @@i18n = {
      status: {
          0: '等待确认',
          1: '拒绝',
          2: '待支付',
          3: '使用中',
          4: '已过期',
          5: '已结束',
      },     
  }
  def display_status
    @@i18n[:status][self.status.to_sym]
  end
end