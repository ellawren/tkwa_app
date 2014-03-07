class NonBillableCategoriesController < ApplicationController

    def new
  	    @non_billable_category = NonBillableCategory.new
    end

    def show
  	    @non_billable_category = NonBillableCategory.find(params[:id])
    end

    def edit
  	    @non_billable_category = NonBillableCategory.find(params[:id])
    end

    def index
  	    @non_billable_categories = NonBillableCategory.all
    end

    def create
        @non_billable_category = NonBillableCategory.new(params[:non_billable_category])
        if @non_billable_category.save
            flash[:success] = "Non-Billable Category created!"
            redirect_to non_billable_categories_path
        else
            render 'new'
        end
    end

    def update
        @non_billable_category = NonBillableCategory.find(params[:id])
        if @non_billable_category.update_attributes(params[:non_billable_category])
            flash[:success] = "Non-Billable Category updated!"
            redirect_to non_billable_categories_path
        else
            render 'edit'
        end
    end

    def destroy
        NonBillableCategory.find(params[:id]).destroy
        flash[:success] = "Non-Billable Category destroyed."
        redirect_to non_billable_categories_path
    end

end
