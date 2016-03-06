class UsersController < ApplicationController
  get '/login' do 
    erb :'/users/login'
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/books'
    else
      erb :'/login'
    end
  end

  get '/signup' do 
    erb :'/users/signup'
  end

  post '/signup' do 
    #I will need to add additional validation later :)
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect '/books'
  end

  get '/logout' do 
    session.clear
    redirect '/'
  end

end