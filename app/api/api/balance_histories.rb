module API
  class BalanceHistories < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    desc 'return my BalanceHistories info' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    get "my" do
      doorkeeper_authorize!
      present current_resource_owner.balance_histories.order(updated_at: :desc), with: API::Entities::BalanceHistory
    end

  end
end
