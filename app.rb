require 'sinatra/base'

class MakersBnB < Sinatra::Base

  get '/signup' do
    erb(:signup)
  end

  post '/register' do
    User.create(email: params[:email], username: params[:username], password: params[:password])
  end

  run! if app_file == $0
end
