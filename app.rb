require './lib/listing.rb'
require 'sinatra/flash'
require 'sinatra/base'
require './database_connection_setup'
require './lib/user'
require './lib/picture'
require './lib/availability'
require './lib/booking'

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
    @listing = Listing.find(id: params[:id])
    @unicorn = @listing.available_dates
    erb (:'listings/show')
  end

  post '/listings' do
    # @user = User.find(id: session[:user_id])
    listing = Listing.create(name: params[:name], description: params[:description], price: params[:price])
    Picture.create(url: params[:picture_url], listing_id: listing.id)
    Available_Dates.create(listing_id: listing.id, date_start: params[:date_start], date_end: params[:date_end])
    flash[:notice] = "Your listing has been added"
    redirect '/'
  end

  get '/listings/:id/enquiry' do
    @listing_id = params[:id]
    erb (:'listings/enquiry')
  end

  post '/listings/:id/enquiry' do
    @listing_id = params[:id]
    @listing = Listing.find(id: @listing_id) #instance of listing 
    @listing_owner_id = @listing.user_id #user ID of owns the listing 
    @listing_owner = User.find(id: @listing_owner_id)
    @listing_owner_email = @listing_owner.email
    @enquiry_user = User.current_user.email
    @enquiry_user_email = @enquiry_user.email 
    #user id making enquire /// user id of listing owner 

    Enquiry.create(subject: params[:subject_line], body: params[:body], to: "#{@listing_owner_email}", from: @enquiry_user_email)
    redirect "/listings/#{@listing_id}/enquiry_confirmation"
  end

  get '/listings/:id/enquiry_confirmation' do
    @listing_id = params[:id]
    erb (:'listings/enquiry_confirmation')
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
    p session[:user_id]
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


  get '/booking/:id/book' do
    @listing
    erb (:'booking/book')
  end

  post '/store_booking' do
    # Booking.create(listing_id: listing.id, user_id: User.current_user.id, book_from: params[:book_from], book_to: params[:book_to])
    redirect '/booking/confirmation'
  end

  get '/booking/confirmation' do
    erb (:'/booking/confirmation')
  end

  run! if app_file == $0
end
