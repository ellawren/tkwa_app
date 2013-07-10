class ProjectsController < ApplicationController
  require 'csv'
  autocomplete :contact, :name, :full => true, :extra_data => [:work_address, :work_phone, :work_ext, :work_email]

  def new
  	@project = Project.new
    render :layout => 'projects_static' 
  end

  def current
    render :layout => 'projects_static' 
  end

  def import
    render :layout => 'projects_static' 
  end

  def edit
    @project = Project.find(params[:id])
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def info
    @project = Project.find(params[:id])
  end
  
  def scope
    @project = Project.find(params[:id])
  end

  def billing
    @project = Project.find(params[:id])
  end

  def shop_drawings
    @project = Project.find(params[:id])
  end

  def patterns
    @project = Project.find(params[:id])
  end

  def marketing
    @project = Project.find(params[:id])
  end

  def summary
    @project = Project.find(params[:id])
    @consultant_list = ConsultantTeam.find(:all, :select => 'DISTINCT consultant_id', :conditions => [ "project_id = #{@project.id}" ] )
  end
  
  def team
    @project = Project.find(params[:id])
    @consultant_list = ConsultantTeam.find(:all, :select => 'DISTINCT consultant_id', :conditions => [ "project_id = #{@project.id}" ] )
  end

  def csv_import  
    file = params[:file]  
    CSV.new(file.tempfile, :headers => true).each do |row|
        if row[3] != ''
          if Project.find_all_by_number(row[3]).count == 0
            Project.create!(:name => row[0],  
                       :location => row[1],  
                       :client => row[2],  
                       :number => row[3],    
                       :building_type => row[4],  
                       :billing_name => "#{row[5]} #{row[6]}", 
                       :billing_address => row[7], 
                       :billing_phone => row[8],  
                       :status => 'Current')  
          end
        end
    end  
    redirect_to projects_current_path
  end



  
  def tracking
    @project = Project.find(params[:id])
    @team_members = EmployeeTeam.find_all_by_project_id(@project.id)
    @all_entries = TimeEntry.find_all_by_project_id(@project.id)
    @phases = @project.available_phases

            estimated = @project.sum_est
            actual = @project.sum_actual
            @percent_complete = actual/estimated *100

            @pd_pc = @project.phase_est('pd').to_f/estimated *100
            @sd_pc = @project.phase_est('sd').to_f/estimated *100
            @dd_pc = @project.phase_est('dd').to_f/estimated *100
            @cd_pc = @project.phase_est('cd').to_f/estimated *100
            @bid_pc = @project.phase_est('bid').to_f/estimated *100
            @cca_pc = @project.phase_est('cca').to_f/estimated *100
            @int_pc = @project.phase_est('int').to_f/estimated *100
            @his_pc = @project.phase_est('his').to_f/estimated *100
            @add_pc = @project.phase_est('add').to_f/estimated *100

            @dd_left = @pd_pc + @sd_pc
            @cd_left = @pd_pc + @sd_pc + @dd_pc
            @bid_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc
            @cca_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc
            @int_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc
            @his_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc + @int_pc
            @add_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc + @int_pc + @his_pc
  end

  def time_diff_in_natural_language(from_time, to_time)
      unless from_time.blank? || to_time.blank?
      from_time = from_time.to_time if from_time.respond_to?(:to_time)
      to_time = to_time.to_time if to_time.respond_to?(:to_time)
      distance_in_seconds = ((to_time - from_time).abs).round
      components = []

      %w(year month week).each do |interval|
      # For each interval type, if the amount of time remaining is greater than
      # one unit, calculate how many units fit into the remaining time.
        if distance_in_seconds >= 1.send(interval)
            delta = (distance_in_seconds / 1.send(interval)).floor
            distance_in_seconds -= delta.send(interval)
            components << pluralize(delta, interval)
        end
      end

      components.join(", ")
      end
     end

  
  def schedule
    @project = Project.find(params[:id])

    unless @project.start_date.blank? || @project.completion_date.blank? 
                 @total = (@project.completion_date - @project.start_date).to_i  

                 if @project.pd_percent.blank? 
                   @pd_pc = 0.05 
                   else 
                   @pd_pc = @project.pd_percent / 100.0 
                   end 

                   if @project.sd_percent.blank? 
                   @sd_pc = 0.1 
                   else 
                   @sd_pc = @project.sd_percent / 100.0 
                   end 

                   if @project.dd_percent.blank? 
                   @dd_pc = 0.15 
                   else 
                   @dd_pc = @project.dd_percent / 100.0 
                   end 

                   if @project.cd_percent.blank? 
                   @cd_pc = 0.4 
                   else 
                   @cd_pc = @project.cd_percent / 100.0 
                   end 

                   if @project.bid_percent.blank? 
                   @bid_pc = 0.05 
                   else 
                   @bid_pc = @project.bid_percent / 100.0 
                   end 

                   if @project.cca_percent.blank? 
                   @cca_pc = 0.25 
                   else 
                   @cca_pc = @project.cca_percent / 100.0 
                   end 

                   if @project.add_percent.blank? 
                   @add_pc = 0.00 
                   else 
                   @add_pc = @project.add_percent / 100.0 
                   end 

                
                pd_start = @project.start_date
                  pd_range = (@total * @pd_pc)
                  pd_end = pd_start + pd_range
                sd_start = pd_end
                  sd_range = (@total * @sd_pc)
                  sd_end = sd_start + sd_range
                dd_start = sd_end
                  dd_range = (@total * @dd_pc)
                  dd_end = dd_start + dd_range
                cd_start = dd_end
                  cd_range = (@total * @cd_pc)
                  cd_end = cd_start + cd_range
                bid_start = cd_end
                  bid_range = (@total * @bid_pc)
                  bid_end = bid_start + bid_range
                cca_start = bid_end
                  cca_range = (@total * @cca_pc)
                  cca_end = cca_start + cca_range
                add_start = cca_end
                  add_range = (@total * @add_pc)
                  add_end = add_start + add_range

                @today = Date.today
                @project_started = false
                @project_over = false

                if @today > add_end 
                  @project_over = true
                  @project_started = true
                  @today_pc = 1
                else
                  today_count = ((@today - @project.start_date).to_i ) * 1.0 
                  @today_pc = today_count / @total
                  if @today >= @project.start_date
                    @project_started = true
                  end
                end

                
                @cca_pc_sum = (@pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc)
                @bid_pc_sum = (@pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc)
                @cd_pc_sum = (@pd_pc + @sd_pc + @dd_pc + @cd_pc)
                @dd_pc_sum = (@pd_pc + @sd_pc + @dd_pc)
                @sd_pc_sum = (@pd_pc + @sd_pc)

                @progress_width = @today_pc * 100
                @pd_width = @pd_pc * 100
                @sd_width = @sd_pc * 100
                @dd_left = (@pd_pc + @sd_pc) * 100
                @dd_width = @dd_pc * 100
                @cd_left = (@pd_pc + @sd_pc + @dd_pc) * 100
                @cd_width = @cd_pc * 100
                @bid_left = (@pd_pc + @sd_pc + @dd_pc + @cd_pc) * 100
                @bid_width = @bid_pc * 100
                @cca_left = (@pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc) * 100
                @cca_width = @cca_pc * 100 
              end

  end
  
  def index
    @q = Project.search(params[:q])
    @projects = @q.result(:distinct => true)
    if @projects.count == 1 
      redirect_to info_project_path(@projects.first(params[:id]))
    else
      render :layout => 'search' 
    end
  end
  
  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:success] = "Project created successfully!"
      redirect_to info_project_path(@project)
    else
      flash[:error] = "Project could not be created."
      render 'new'
    end
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated successfully!"
      redirect_to(:back) 
    else
      redirect_to(:back) 
    end
  end
  
  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted."
    redirect_to(:back) 
  end
  
end
