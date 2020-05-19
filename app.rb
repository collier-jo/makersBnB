require 'sinatra/base'
require './database_connection_setup'
require './lib/user'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @user = User.find(id: session[:user_id])
  end

  get '/signup' do
    erb(:signup)
  end

  post '/register' do
    begin
      user = User.create(email: params[:email], username: params[:username], password: params[:password])
    rescue PG::UniqueViolation
      redirect '/signup'
      flash[:notice] = "this username/email already exists"
    end
    session[:user_id] = user.id
    redirect '/'
  end

  run! if app_file == $0
end
