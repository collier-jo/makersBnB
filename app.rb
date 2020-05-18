require 'sinatra/base'

class MakersBnB < Sinatra::Base

  get '/signup' do
    erb(:signup)
  end

  post '/register' do
    p params
  end

  run! if app_file == $0
end
