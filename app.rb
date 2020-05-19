require './lib/listing.rb'
require 'sinatra/flash'

require 'sinatra/base'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @listings = Listing.all
    erb :index
  end

  get '/listings/new' do
    erb :'listings/new'
  end

  post '/listings' do
    name = params[:name]
    description = params[:description]
    price = params[:price]
    Listing.create(name: params[:name], description: params[:description], price: params[:price])
    # connection = PG.connect(dbname: 'makers_bnb_test')
    # connection.exec("INSERT INTO listings (name, description, price) VALUES ('#{name}', '#{description}', '#{price}');")
    flash[:notice] = "Your listing has been added"
    redirect '/'
  end

  run! if app_file == $0
end
