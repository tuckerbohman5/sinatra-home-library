class BooksController < ApplicationController


  get '/books' do
    erb :'/books/index'
  end
  
  get '/books/new' do 
    @authors = Author.all
    erb :'/books/new'
  end
end