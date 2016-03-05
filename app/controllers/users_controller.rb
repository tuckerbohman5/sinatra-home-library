class UsersController < ApplicationController
  post '/login' do 
  end

  get '/signup' do 
    erb :'/users/signup'
  end

end