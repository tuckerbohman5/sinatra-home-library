class BooksController < ApplicationController
  get '/books' do
    erb :'/books/index'
  end
  
  get '/books/new' do 
    @authors = Author.all
    erb :'/books/new'
  end

  post '/books' do 
    @book = Book.new
    if params[:author][:first_name] != ""
      @book.author = Author.create(params[:author])
    else
      @book.author = Author.find(params[:author_id])
    end
      
     @book.title = params[:title] 
    @book.save
    current_user.books << @book
    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do 
    @book = Book.find(params[:id])
    erb :'/books/show'
  end

  get '/books/:id/edit' do 
    @book = Book.find(params[:id])
    erb :'/books/edit'
  end

  post '/books/:id' do 
    @book = Book.find(params[:id])
    @book.update(title: params[:title])
    @book.author.update(params[:author])
    redirect "/books/#{@book.id}"
  end

  get '/books/:id/delete' do 
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