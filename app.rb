require 'sinatra/base'

class MakersBnB < Sinatra::Base

  get '/' do
    @listings = Listing.all
    erb :index
  end

  run! if app_file == $0
end
