module API
  class Games < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    desc 'gets the Games list'
    params do
      use :pagination
    end
    get "list" do
      present Game.published.order(updated_at: :desc).page(params[:page]).per(params[:per_page]), with: API::Entities::GameBrief
    end

    desc 'return a Game info'
    params do
      optional :id, type: Integer, desc: 'Game id.'
      optional :name, type: String, desc: 'Game name.'
    end
    get "info" do
      if (conditions = declared(params, include_missing: false)).present?
        game = Game.find_by(conditions)
        present game, with: API::Entities::Game
      end
    end

  end
end
