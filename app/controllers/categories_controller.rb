class CategoriesController < ApplicationController
  def new
  	@category = Category.new
  end

  def show
  	@category = Category.find(params[:id])
  end

  def edit
  	@category = Category.find(params[:id])
  end

  def index
  	@categories = Category.all
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success] = "Category updated!"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category destroyed."
    redirect_to categories_path
  end
end
