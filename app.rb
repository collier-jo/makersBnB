require 'sinatra/base'

class MakersBnB < Sinatra::Base

  get '/signup' do
    'Sign Up'
  end

  run! if app_file == $0
end
