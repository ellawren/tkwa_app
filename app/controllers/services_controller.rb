class ServicesController < ApplicationController
  def new
   @title = "Add New Service"
   @service = Service.new

   respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  def show
    @service = Service.find(params[:id])
  end

  def create
    @service = Service.new(params[:service])
    if @service.save
      flash[:success] = "Service created successfully!"
      redirect_to services_path
    else
      render 'new'
    end
  end

  def destroy
    Service.find(params[:id]).destroy
    flash[:success] = "Service deleted."
    redirect_to services_path
  end


  def edit
   @service = Service.find(params[:id])
    @title = "Edit Service"
  end

  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:success] = "Service updated."
      redirect_to @service
    else
      @title = "Edit service"
      render 'edit'
    end
  end

  def index
    @title = "All services"
    @services = Service.all
  end

end