class HolidaysController < ApplicationController
  def index
    # @holidays = Holiday.paginate(page: params[:page])
    @holidays = Holiday.all
  end

  def show
    @holiday = Holiday.find(params[:id])
  end

  def new
    @holiday = Holiday.new
  end

  def create
    @holiday = Holiday.new(params[:holiday])
    if @holiday.save

          Employee.all.each do |e|
              tm = Timesheet.find_or_create_by_employee_id_and_year_and_week(e.id, @holiday.date.year, view_context.get_week_number(@holiday.date))
              nb = NonBillableEntry.find_or_create_by_employee_id_and_timesheet_id_and_category_and_description(e.id, tm.id, "Holiday", @holiday.name)
              hh = DataRecord.find_by_employee_id_and_year(e.id, @holiday.date.year).holiday || 8
              eval("nb.day#{@holiday.date.wday + 1} = #{hh.to_f}")
              nb.save
              tm.save
          end
      flash[:success] = "Holiday added successfully!"
      redirect_to holidays_path
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
    NonBillableEntry.find_all_by_description(hol_name).each do |nb|
      nb.destroy
    end
    Holiday.find(params[:id]).destroy
    flash[:success] = "Holiday destroyed."
    redirect_to holidays_path
  end
  
end
