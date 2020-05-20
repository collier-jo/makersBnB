require './lib/listing.rb'
require 'sinatra/flash'
require 'sinatra/base'
require './database_connection_setup'
require './lib/user'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @listings = Listing.all
    @user = User.find(id: session[:user_id])
    flash[:signout] = "You must be signed in before adding a new listing"
    erb :index
  end

  get '/listings/new' do
    redirect '/' if User.current_user == nil
    erb :'listings/new'
  end

  get '/listings/:id/show' do
    p params
    #@listing = Listing.find(id: params[:id])
    erb (:'listings/show') # I know this works now
  end

  post '/listings' do
    Listing.create(name: params[:name], description: params[:description], price: params[:price])
    flash[:notice] = "Your listing has been added"
    redirect '/'
  end

  get '/signup' do
    flash[:warning] = "this username/email already exists"
    erb(:signup)
  end

  post '/register' do
    begin
      user = User.create(email: params[:email], username: params[:username],
        password: params[:password])
    rescue PG::UniqueViolation
      redirect '/signup'
    end
    session[:user_id] = user.id
    redirect '/'
  end

  get '/sessions/new' do
    erb :'/sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(username: params[:username], password: params[:password])

    if user
      session[:user_id] = user.id
      # flash[:welcome_user] = "Welcome #{user.username}!"
      redirect '/'
    else
      flash[:notice] = 'Please check your username or password!'
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    User.sign_out
    flash[:notice] = 'You have signed out!'
    redirect '/'
  end

  run! if app_file == $0
end
