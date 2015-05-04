class KeyCategoriesController < ApplicationController
  def new
  	    @key_category = KeyCategory.new
    end

    def show
  	    @key_category = KeyCategory.find(params[:id])
    end

    def edit
  	    @key_category = KeyCategory.find(params[:id])
    end

    def index
  	    @key_categories = KeyCategory.all
    end

    def create
        @key_category = KeyCategory.new(params[:key_category])
        if @key_category.save
            flash[:success] = "Key Category created!"
            redirect_to key_categories_path
        else
            render 'new'
        end
    end

    def update
        @key_category = KeyCategory.find(params[:id])
        if @key_category.update_attributes(params[:key_category])
            flash[:success] = "Key Category updated!"
            redirect_to key_categories_path
        else
            render 'edit'
        end
    end

    def destroy
        KeyCategory.find(params[:id]).destroy
        flash[:success] = "Key Category destroyed."
        redirect_to key_categories_path
    end
end
