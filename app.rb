require './lib/listing.rb'
require 'sinatra/flash'
require 'sinatra/base'
require './database_connection_setup'
require './lib/user'
require './lib/picture'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override
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
    # p params
    @listing = Listing.find(id: params[:id])
    erb (:'listings/show')
  end

  post '/listings' do
    listing = Listing.create(name: params[:name], description: params[:description], price: params[:price])
    Picture.create(url: params[:picture_url], listing_id: listing.id)
    flash[:notice] = "Your listing has been added"
    redirect '/'
  end

  get "/users/:username/user" do
    p params
    @user = User.current_user
    @listings = @user.listings
    session[:username] = @user.username
    erb :'/users/user'
  end

  get "/listings/:id/edit" do
    @listing_id = params[:id]
    @listing = Listing.find(id: @listing_id)
    erb :'listings/edit'
  end

  patch '/listings/:id' do
    p "Patch #{params}"
    listing = Listing.update(id: params[:id], name: params[:name], description: params[:description], price: params[:price])
    Picture.update(url: params[:url], listing_id: listing.id)
    redirect "/users/#{session[:username]}/user"
  end

  delete '/listings/:id' do
    Picture.delete(listing_id: params[:id])
    Listing.delete(id: params[:id])
    redirect "/users/#{session[:username]}/user"
  end

  get '/signup' do
    flash[:warning] = "this username/email already exists"
    erb :signup
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
    # p session[:user_id]
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
