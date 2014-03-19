class BooksController < ApplicationController
    require 'csv'
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
            redirect_to edit_book_path(@book)
        else
            render 'new'
        end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update_attributes(params[:book])
            flash[:success] = "Book updated!"
            redirect_to edit_book_path(@book)
        else
            render 'edit'
        end
    end

    def destroy
        Book.find(params[:id]).destroy
        flash[:success] = "Book destroyed."
        redirect_to library_path
    end

    def import
    end

    def lib_csv_import  
        file = params[:file]  
        CSV.new(file.tempfile, :headers => true).each do |row|
            if Book.find_all_by_title(row[1]).count == 0
                book = Book.create!(
                    :shelf_location => row[0],  
                    :title => row[1],  
                    :author => row[2], 
                    :description => row[3],    
                    :date => row[4],  
                    :categories => "#{row[5] + "\n" + row[6]}",
                    :material_type => row[7], 
                    :index => row[8],  
                    :status => row[9],
                    :borrower => row[10]
                  )
            end
        end  
        redirect_to library_path
    end

end
