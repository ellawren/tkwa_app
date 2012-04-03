class GlobalsController < ApplicationController

  def index
    # @globals = Global.paginate(page: params[:page])
    @globals = Global.all
  end

  def show
    @global = Global.find(params[:id])
  end

  def edit
    @global = Global.find(params[:id])
  end

  def new
    @global = Global.new
  end

  def create
    @global = Global.new(params[:global])
    if @global.save
      flash[:success] = "Global added successfully!"
      redirect_to globals_path
    else
      render 'new'
    end
  end


  def update
    @global = Global.find(params[:id])
    if @global.update_attributes(params[:global])
      flash[:success] = "Global updated successfully!"
      redirect_to globals_path
    else
      render 'edit'
    end
  end

  def destroy
    Global.find(params[:id]).destroy
    flash[:success] = "Global destroyed."
    redirect_to globals_path
  end

end
