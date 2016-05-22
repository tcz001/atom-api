module API
  class UrlBinds < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    get "list" do
      present UrlBind.order(id: :desc), with: API::Entities::UrlBind
    end
  end
end
