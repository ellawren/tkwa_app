class MarketingCategoriesController < ApplicationController

	def new
  	    @marketing_category = MarketingCategory.new
    end

    def show
  	    @marketing_category = MarketingCategory.find(params[:id])
    end

    def edit
  	    @marketing_category = MarketingCategory.find(params[:id])
    end

    def index
  	    @marketing_categories = MarketingCategory.all
    end

    def create
        @marketing_category = MarketingCategory.new(params[:marketing_category])
        if @marketing_category.save
            flash[:success] = "Category created!"
            redirect_to marketing_categories_path
        else
            render 'new'
        end
    end

    def update
        @marketing_category = MarketingCategory.find(params[:id])
        if @marketing_category.update_attributes(params[:marketing_category])
            flash[:success] = "Category updated!"
            redirect_to marketing_categories_path
        else
            render 'edit'
        end
    end

    def destroy
        MarketingCategory.find(params[:id]).destroy
        flash[:success] = "Category destroyed."
        redirect_to marketing_categories_path
    end

end
