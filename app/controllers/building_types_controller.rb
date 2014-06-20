class BuildingTypesController < ApplicationController

  	def index
        @building_types = BuildingType.all
    end

    def new
        @building_type = BuildingType.new
    end

    def create
        @building_type = BuildingType.new(params[:building_type])
        if @building_type.save
            redirect_to building_types_path
        else
            render 'new'
        end
    end

    def edit
        @building_type = BuildingType.find(params[:id])
    end

    def update
        @building_type = BuildingType.find(params[:id])
        if @building_type.update_attributes(params[:building_type])
            flash[:success] = "Building type updated"
            redirect_to building_types_path
        else
            render 'edit'
        end
    end

    def destroy
        BuildingType.find(params[:id]).destroy
        flash[:success] = "Building type destroyed."
        redirect_to building_types_path
    end

end
