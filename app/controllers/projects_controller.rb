class ProjectsController < ApplicationController
  autocomplete :contact, :name, :full => true, :extra_data => [:work_address, :work_phone, :work_ext, :work_email]

  def new
  	@project = Project.new
    render :layout => 'new_project' 
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
  
  def team
    @project = Project.find(params[:id])
    @consultant_list = ConsultantTeam.find(:all, :select => 'DISTINCT consultant_id', :conditions => [ "project_id = #{@project.id}" ] )

  end
  
  def tracking
    @project = Project.find(params[:id])
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
    @projects = Project.paginate(page: params[:page])
    render :layout => 'index_projects'
  end
  
  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:success] = "Project created successfully!"
      redirect_to info_project_path(@project)
    else
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
    redirect_to projects_path
  end
  
end
