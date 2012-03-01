class CategoriesController < ApplicationController
  def new
  end

  def show
  end

  def edit
  end

  def index
  	@categories = Category.all
  end
end
