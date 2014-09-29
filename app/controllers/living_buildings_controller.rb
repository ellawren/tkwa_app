class LivingBuildingsController < ApplicationController

    def new
  	    @living_building = LivingBuilding.new
    end

    def show
  	    @living_building = LivingBuilding.find(params[:id])
    end

    def edit
  	    @living_building = LivingBuilding.find(params[:id])
    end

    def index
  	    @living_buildings = LivingBuilding.all
    end

    def create
        @living_building = LivingBuilding.new(params[:living_building])
        if @living_building.save
            flash[:success] = "Living Building version created!"
            redirect_to living_buildings_path
        else
            render 'new'
        end
    end

    def update
        @living_building = LivingBuilding.find(params[:id])
        if @living_building.update_attributes(params[:living_building])
            flash[:success] = "Living Building updated!"
            redirect_to living_buildings_path
        else
            render 'edit'
        end
    end

    def destroy
        LivingBuilding.find(params[:id]).destroy
        flash[:success] = "Living Building destroyed."
        redirect_to living_buildings_path
    end

end
