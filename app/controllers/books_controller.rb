class BooksController < ApplicationController
  get '/books' do
    redirect_if_not_logged_in
    erb :'/books/index'
  end
  
  get '/books/new' do 
    redirect_if_not_logged_in
    @authors = Author.all
    @error_message = params[:error]
    erb :'/books/new'
  end

  post '/books' do 
    redirect_if_not_logged_in
    @book = Book.new
    if params[:author][:first_name] != "" && params[:author][:last_name] != ""
      @book.author = Author.create(params[:author])
    elsif params[:author_id] == "999" 
            redirect "/books/new?error=Please select or create a valid author"
    elsif @author = Author.find(params[:author_id])
      @book.author = @author
    else
      redirect "/books/new?error=Please select or enter a valid author"
    end
      
     @book.title = params[:title] 
     if @book.title = ""
      redirect "/books/new?error=Please enter a title"
      else
     @book.save
   end
    
    current_user.books << @book
    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do
    redirect_if_not_logged_in 
    @book = Book.find(params[:id])
    erb :'/books/show'
  end

  get '/books/:id/edit' do 
    redirect_if_not_logged_in
    @book = Book.find(params[:id])
    @error_message = params[:error]
    erb :'/books/edit'
  end

  post '/books/:id' do 
    redirect_if_not_logged_in
    @book = Book.find(params[:id])
    if params[:title] != ""
    @book.update(title: params[:title])
    else
      redirect "/books/#{@book.id}/edit?error=Please enter a valid title!"
    end
    if params[:author][:first_name] != "" && params[:author][:last_name] != ""
    @book.author.update(params[:author])
    redirect "/books/#{@book.id}"
    else
      redirect "/books/#{@book.id}/edit?error=Please enter a valid author!"
    end
  end

  get '/books/:id/delete' do 
    redirect_if_not_logged_in
    @book = Book.find(params[:id])
    if current_user.id == @book.user_id
      @book.delete
      redirect '/books'
    else
      #error message
      redirect '/books'
    end

  end

end