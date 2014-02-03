class ShopDrawingsController < ApplicationController
	
  	def show
	    @shop_drawings = ShopDrawing.find(params[:id])
	end

	def new
	    @shop_drawing = ShopDrawing.new
	    @project = Project.find(params[:project_id])
	    render :layout => 'modal' 
	end

	def create
	    @shop_drawing = ShopDrawing.new(params[:shop_drawing])
	    if @shop_drawing.save
	      redirect_to shop_drawings_project_path(Project.find(@shop_drawing.project_id))
	    else
	    	flash[:error] = 'Schedule item could not be created.'
	    	redirect_to(:back) 
	    end
	end

	def edit
	    @shop_drawing = ShopDrawing.find(params[:id])
	    @project = Project.find(@shop_drawing.project_id)
	    @consultant = Consultant.find(@shop_drawing.consultant_id)
	    render :layout => 'modal' 
	end

	def update
	    @shop_drawing = ShopDrawing.find(params[:id])
	    if @shop_drawing.update_attributes(params[:shop_drawing])
	      flash[:success] = "Shop Drawing updated!"
	      redirect_to shop_drawing_project_path(Project.find(@shop_drawing.project_id))
	    else
	      flash[:error] = 'Shop Drawing could not be updated.'
	      redirect_to(:back) 
	    end
	end

	def destroy
	    ShopDrawing.find(params[:id]).destroy
	    flash[:success] = "Shop drawing deleted."
	    redirect_to(:back) 
	end

end
