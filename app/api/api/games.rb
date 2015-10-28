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
      present Game.find_by(declared(params, include_missing: false)), with: API::Entities::Game
    end

  end
end
