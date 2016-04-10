module LeaseOrdersHelper
  def self.check_balance(user, lease_order)
    if user.free_credit_balance >= lease_order.frozen_amount && user.free_balance >= lease_order.total_amount
      return true
    elsif user.free_balance >= lease_order.total_amount+lease_order.frozen_amount
      return true
    elsif user.free_balance > lease_order.total_amount && (user.free_balance - lease_order.total_amount) + user.free_credit_balance >= lease_order.frozen_amount
      return true
    end
    false
  end

  def self.cal_lack_of_balance(user, lease_order)
    user.free_credit_balance >= lease_order.frozen_amount ?
        (lease_order.total_amount - user.free_balance) : ((lease_order.frozen_amount + lease_order.total_amount) - (user.free_credit_balance + user.free_balance))
  end

  def self.freeze(user, lease_order)
    return unless check_balance(user, lease_order)
    if user.free_credit_balance >= lease_order.frozen_amount
      freeze_credit = lease_order.frozen_amount
      freeze_amount = lease_order.total_amount
    else
      freeze_credit = user.free_credit_balance
      freeze_amount = lease_order.total_amount + (lease_order.frozen_amount - user.free_credit_balance)
    end
    if freeze_credit > 0
      user.free_credit_balance -= freeze_credit
      user.frozen_credit_balance += freeze_credit
      user.balance_histories.build(
          {
              event: '冻结信用币',
              amount: freeze_credit,
              related_order: lease_order.serial_number,
          })
    end
    user.free_balance -= freeze_amount
    user.frozen_balance += freeze_amount
    user.balance_histories.build(
        {
            event: '冻结游戏币',
            amount: freeze_amount,
            related_order: lease_order.serial_number,
        })
  end
end