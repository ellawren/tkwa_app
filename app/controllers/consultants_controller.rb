class ConsultantsController < ApplicationController
  
  def index
    # @consultants = Consultant.paginate(page: params[:page])
    @consultants = Consultant.all
  end

  def show
    @consultant = Consultant.find(params[:id])
  end

  def new
    @consultant = Consultant.new
  end

  def create
    @consultant = Consultant.new(params[:consultant])
    if @consultant.save
      redirect_to @consultant
    else
      render 'new'
    end
  end

  def edit
    @consultant = Consultant.find(params[:id])
  end

  def update
    @consultant = Consultant.find(params[:id])
    if @consultant.update_attributes(params[:consultant])
      flash[:success] = "Consultant updated"
      redirect_to @consultant
    else
      render 'edit'
    end
  end

  def destroy
    Consultant.find(params[:id]).destroy
    flash[:success] = "Consultant destroyed."
    redirect_to consultants_path
  end

end
