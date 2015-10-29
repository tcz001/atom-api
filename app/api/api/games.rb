module API
  class Games < Grape::API
    use Rack::JSONP

    desc 'gets the Games'
    get "all" do
      present Game.all, with: API::Entities::Game
    end

    desc 'return a Game info'
    params do
      optional :name, type: String, desc: 'Game name.'
    end
    get "info" do
      if (conditions = declared(params, include_missing: false)).present?
        present Game.find_by(conditions), with: API::Entities::Game
      end
    end

  end
end
