class VacationsController < ApplicationController
  def new
  	@vacation = Vacation.new
  end

  def edit
  	@vacation = Vacation.find(params[:id])
  end

  def index
  	@user = User.find(params[:user_id])
  end
end
