class ReimbursablesController < ApplicationController
  
  def index
    @reimbursables = Reimbursable.all
  end

  def show
    @reimbursable = Reimbursable.find(params[:id])
  end

  def new
    @reimbursable = Reimbursable.new
  end

  def create
    @reimbursable = Reimbursable.new(params[:reimbursable])
    if @reimbursable.save
      redirect_to reimbursables_path
    else
      render 'new'
    end
  end

  def edit
    @reimbursable = Reimbursable.find(params[:id])
  end

  def update
    @reimbursable = Reimbursable.find(params[:id])
    if @reimbursable.update_attributes(params[:reimbursable])
      flash[:success] = "Reimbursable updated"
      redirect_to reimbursables_path
    else
      render 'edit'
    end
  end

  def destroy
    Reimbursable.find(params[:id]).destroy
    flash[:success] = "Reimbursable destroyed."
    redirect_to reimbursables_path
  end

end