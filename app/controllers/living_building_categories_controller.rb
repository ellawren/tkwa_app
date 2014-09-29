class LivingBuildingCategoriesController < ApplicationController

    def new
  	    @living_building_category = LivingBuildingCategory.new
    end

    def show
  	    @living_building_category = LivingBuildingCategory.find(params[:id])
    end

    def edit
  	    @living_building_category = LivingBuildingCategory.find(params[:id])
    end

    def index
  	    @living_building_categories = LivingBuildingCategory.order("numerical_order ASC")
    end

    def create
        @living_building_category = LivingBuildingCategory.new(params[:living_building_category])
        if @living_building_category.save
            flash[:success] = "Living Building category created!"
            redirect_to living_building_categories_path
        else
            render 'new'
        end
    end

    def update
        @living_building_category = LivingBuildingCategory.find(params[:id])
        if @living_building_category.update_attributes(params[:living_building_category])
            flash[:success] = "Living Building category updated!"
            redirect_to living_building_categories_path
        else
            render 'edit'
        end
    end

    def destroy
        LivingBuildingCategory.find(params[:id]).destroy
        flash[:success] = "Living Building category destroyed."
        redirect_to living_building_categories_path
    end

end
