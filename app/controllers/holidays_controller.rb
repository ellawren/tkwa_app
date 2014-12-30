class HolidaysController < ApplicationController

    def index
        @holidays = Holiday.all
    end

    def by_year
        @year = params[:year]
        @holidays = Holiday.where(year: @year)
    end

    def show
        @holiday = Holiday.find(params[:id])
    end

    def edit
        @holiday = Holiday.find(params[:id])
    end

    def new
        @holiday = Holiday.new
    end

    def create
        @holiday = Holiday.new(params[:holiday])
        if @holiday.save
            flash[:success] = "Holiday added successfully!"
            redirect_to holidays_by_year_path(@holiday.year)
        else
            render 'new'
        end
    end

    def update
        @holiday = Holiday.find(params[:id])
        if @holiday.update_attributes(params[:holiday])
            flash[:success] = "Holiday updated successfully!"
            redirect_to @holiday
        else
            render 'edit'
        end
    end

    def destroy
        hol_name = Holiday.find(params[:id]).name
        NonBillableEntry.where(description: hol_name).each do |nb|
            nb.destroy
        end
        Holiday.find(params[:id]).destroy
        flash[:success] = "Holiday destroyed."
        redirect_to holidays_by_year_path(Date.today.year)
    end
  
end
