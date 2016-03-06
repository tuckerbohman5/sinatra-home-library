class UsersController < ApplicationController
  get '/login' do 
    if logged_in?
      redirect '/books'
    else
    @error_message = params[:error]
    erb :'/users/login'
    end
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
    if logged_in?
      redirect '/books'
    else
    erb :'/users/signup'
    end
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