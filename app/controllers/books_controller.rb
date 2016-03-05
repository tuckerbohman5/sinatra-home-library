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
    @author = Author.find(params[:author_id])

    if @author 
      @book.author = @author
    else 
      @author_new = Author.create(params[:author])
      @book.author = @author_new
    end
    @book.title = params[:title]
    
    @book.save

    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do 
    @book = Book.find(params[:id])
    erb :'/books/show'
  end

end