class PatternsController < ApplicationController

	require 'csv'

	def by_project
	    @p = Pattern.search(params[:p])
	    if params.has_key?(:p)
	    	redirect_to patterns_by_project_path(params[:p][:project_id_eq])
	    end
	end

	def index
		@q = Pattern.search(params[:q])
	    @patterns = @q.result(:distinct => true).order("project_id ASC, number ASC")
	end

	def all
	    @patterns = Pattern.by_project.paginate(:page => params[:page], :per_page => 30)
	end

	def show
	    @pattern = Pattern.find(params[:id])
	end

	def new
	    @pattern = Pattern.new
	end

	def projects
		@project = Project.find(params[:id])
		@patterns = Pattern.where(:project_id => params[:id]).order(:number)
	end


	def print
		@project = Project.find(params[:id])
		@patterns = Pattern.where(:project_id => params[:id]).order(:number)

    	respond_to do |format|
	      	format.html { render :layout => 'patterns-print' }
	      	format.pdf do
	        	render :pdf => "#{@project.name} Patterns", :layout => 'pdf.html.erb' 
	      	end
	    end
	end

	def print_tabloid
		@project = Project.find(params[:id])
		@patterns = Pattern.where(:project_id => params[:id]).order(:number)
	    respond_to do |format|
	      	format.html { render :layout => 'patterns-print' }
	      	format.pdf do
	        	pdf = PatternPdf.new(@patterns, @project.name, view_context)
	        	send_data pdf.render, filename: "patterns-081314.pdf", type: "application/pdf"
	      	end
	    end
	end

	def import
    end

    def patt_csv_import  
        file = params[:file]  
        CSV.new(file.tempfile, :headers => true).each do |row|
                pattern = Pattern.create!(
                   :name => row[0], 
                   :project_name => row[1], 
                   :number => row[2],  
                   :background => row[4],    
                   :challenges => row[5],  
                   :issue => row[6], 
                   :solution => row[7], 
                   :notes => "#{row[3] + "\n" if row[3].present?}#{row[8] + "\n" if row[8].present?}#{row[9] if row[9].present?}"

                  )

        end  
        redirect_to patterns_path
    end

	def create
	    @pattern = Pattern.new(params[:pattern])
	    if @pattern.save
	      	#redirect_to patterns_by_project_path(@pattern.project_id)
	      	redirect_to edit_pattern_path(@pattern)
	    else
	    	render 'new'
	    end
	end

	def edit
	    @pattern = Pattern.find(params[:id])
	end

	def update
	    @pattern = Pattern.find(params[:id])
	    if @pattern.update_attributes(params[:pattern])
	      flash[:success] = "Pattern updated!"
	      redirect_to edit_pattern_path(@pattern)
	    else
	      render 'edit'
	    end
	end

	def destroy
		project_id = Pattern.find(params[:id]).project_id
	    Pattern.find(params[:id]).destroy
	    flash[:success] = "Pattern destroyed."
	    if project_id.present?
	    	redirect_to patterns_by_project_path(project_id)
	    else
	    	redirect_to all_patterns_by_project_path
	    end

	end

end
