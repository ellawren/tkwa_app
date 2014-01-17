class ConsultantRolesController < ApplicationController
  
  def index
    @consultant_roles = ConsultantRole.all
  end

  def show
    @consultant_role = ConsultantRole.find(params[:id])
  end

  def new
    @consultant_role = ConsultantRole.new
  end

  def create
    @consultant_role = ConsultantRole.new(params[:consultant_role])
    if @consultant_role.save
      redirect_to consultant_roles_path
    else
      render 'new'
    end
  end

  def edit
    @consultant_role = ConsultantRole.find(params[:id])
  end

  def update
    @consultant_role = ConsultantRole.find(params[:id])
    if @consultant_role.update_attributes(params[:consultant_role])
      flash[:success] = "Consultant role updated"
      redirect_to consultant_roles_path
    else
      render 'edit'
    end
  end

  def destroy
    ConsultantRole.find(params[:id]).destroy
    flash[:success] = "Consultant role destroyed."
    redirect_to consultant_roles_path
  end

end
