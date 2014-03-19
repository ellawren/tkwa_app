class BooksController < ApplicationController

  	def new
  	    @book = Book.new
    end

    def show
  	    @book = Book.find(params[:id])
    end

    def edit
  	    @book = Book.find(params[:id])
    end

    def index
  	    @books = Book.all
    end

    def create
        @book = Book.new(params[:book])
        if @book.save
            flash[:success] = "Book created!"
            redirect_to books_path
        else
            render 'new'
        end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update_attributes(params[:book])
            flash[:success] = "Book updated!"
            redirect_to books_path
        else
            render 'edit'
        end
    end

    def destroy
        Category.find(params[:id]).destroy
        flash[:success] = "Book destroyed."
        redirect_to books_path
    end

end
