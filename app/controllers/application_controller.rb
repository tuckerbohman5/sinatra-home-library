require './config/environment'

class ApplicationController < Sinatra::Base
  configure do 
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret_family_library'
  end

  get '/' do 
    erb :'/home'
  end
end