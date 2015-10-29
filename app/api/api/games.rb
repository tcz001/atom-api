module API
  class Games < Grape::API
    use Rack::JSONP

    desc 'gets the Games'
    get "all" do
      present Game.all, with: API::Entities::Game
    end

    desc 'return a Game info'
    params do
      optional :id, type: Integer, desc: 'Game id.'
      optional :name, type: String, desc: 'Game name.'
    end
    get "info" do
      if (conditions = declared(params, include_missing: false)).present?
        @game = Game.find_by(conditions)
        present @game, with: API::Entities::Game
      end
    end

  end
end
