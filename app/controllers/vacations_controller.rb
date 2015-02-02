class VacationsController < ApplicationController
    def new
  	    @vacation = Vacation.new
    end

    def edit
  	    @vacation = Vacation.find(params[:id])
    end

    def all
        @year = params[:year]
  	    @vacations = Vacation.where(year: @year)
        @months = [1,2,3,4,5,6,7,8,9,10,11,12]
    end

    def index
  	    @user = User.find(params[:user_id])
    end

end
