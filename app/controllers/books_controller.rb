class BooksController < ApplicationController
  def show
    render json: Book.find(book_id), serializer: BookSerializer
  end

  def index

    @book=Book.all
   
   render_paginated json: Book.all, each_serializer: BookSerializer
  end

  def book_information

      render json: OpenLibraryBooksService.new.retrieve_book_information_by_isbn(isbn_param)
    rescue RuntimeError => e
      render_errors(e.message, :not_found)
  end

  def new_book

    data = OpenLibraryBooksService.new.retrieve_book_information_by_isbn(isbn_param)
    book = Book.new
    book.genre = "no_data"
    book.author = data[:authors][0][:name]
    book.title = data[:title]
    book.publisher = data[:publishers][0][:name]
    book.year = data[:publish_date]
    book.image = data[:cover][:small]
    book.save

    render json: book

  end

  def favorite_books

    user_id = current_user.id
    book_fav = FavoriteBook.new
    book_fav.book_id = params[:book_id] if params[:book_id]
    book_fav.user_id = user_id
    book_fav.save if current_user.status_account_id !=1

    render json: book_fav

  end

  def my_books

    render json: @book=FavoriteBook.all.where("user_id=? and status_account_id != 1",current_user.id)
    
  end

  private

  def book_id
    params.require(:id)
  end

  def isbn_param
    params.require(:isbn)
  end
end
