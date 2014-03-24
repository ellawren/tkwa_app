module BooksHelper
	def new_index
        Book.order("index ASC").last.index + 1
    end
end
