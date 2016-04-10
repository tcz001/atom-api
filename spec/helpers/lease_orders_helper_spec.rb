require 'rails_helper'
require_relative '../../lib/helpers/lease_orders_helper'

# Specs in this file have access to a helper object that includes
# the LeaseOrdersHelper. For example:
#
# describe LeaseOrdersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe LeaseOrdersHelper, type: :helper do
  it 'should check balance' do
    user = User.new({free_credit_balance: 100, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 10})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be true

    user = User.new({free_credit_balance: 0, free_balance: 200})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be true

    user = User.new({free_credit_balance: 80, free_balance: 120})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be true

    user = User.new({free_credit_balance: 0, free_balance: 100})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 10})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be false

    user = User.new({free_credit_balance: 80, free_balance: 100})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be false

    user = User.new({free_credit_balance: 100, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be false

    user = User.new({free_credit_balance: 200, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::check_balance(user, lease_order)).to be false
  end

  it 'should cal lack balance' do
    user = User.new({free_credit_balance: 100, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 10})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 0

    user = User.new({free_credit_balance: 0, free_balance: 200})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 0

    user = User.new({free_credit_balance: 80, free_balance: 120})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 0

    user = User.new({free_credit_balance: 0, free_balance: 100})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 10})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 10

    user = User.new({free_credit_balance: 80, free_balance: 100})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 20

    user = User.new({free_credit_balance: 100, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 90

    user = User.new({free_credit_balance: 200, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    expect(LeaseOrdersHelper::cal_lack_of_balance(user, lease_order)).to eq 90
  end

  it 'should freeze' do
    user = User.new({free_credit_balance: 100, free_balance: 10})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 10})
    LeaseOrdersHelper::freeze(user, lease_order)
    expect(user.balance_histories.length).to eq 2
    expect(user.free_credit_balance).to eq 0
    expect(user.free_balance).to eq 0
    expect(user.frozen_credit_balance).to eq 100
    expect(user.frozen_balance).to eq 10

    user = User.new({free_credit_balance: 0, free_balance: 200})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    LeaseOrdersHelper::freeze(user, lease_order)
    expect(user.balance_histories.length).to eq 1
    expect(user.free_credit_balance).to eq 0
    expect(user.free_balance).to eq 0
    expect(user.frozen_credit_balance).to eq 0
    expect(user.frozen_balance).to eq 200

    user = User.new({free_credit_balance: 80, free_balance: 120})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 100})
    LeaseOrdersHelper::freeze(user, lease_order)
    expect(user.balance_histories.length).to eq 2
    expect(user.free_credit_balance).to eq 0
    expect(user.free_balance).to eq 0
    expect(user.frozen_credit_balance).to eq 80
    expect(user.frozen_balance).to eq 120

    user = User.new({free_credit_balance: 0, free_balance: 100})
    lease_order = LeaseOrder.new({frozen_amount: 100, total_amount: 10})
    LeaseOrdersHelper::freeze(user, lease_order)
    expect(user.balance_histories.length).to eq 0
    expect(user.free_credit_balance).to eq 0
    expect(user.free_balance).to eq 100
    expect(user.frozen_credit_balance).to eq 0
    expect(user.frozen_balance).to eq 0
  end
end
