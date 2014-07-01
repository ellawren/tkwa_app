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
	    @patterns = @q.result(:distinct => true)
	end

	def show
	    @pattern = Pattern.find(params[:id])
	end

	def new
	    @pattern = Pattern.new
	end

	def projects
		@project = Project.find(params[:id])
		@patterns = Pattern.find_all_by_project_id(params[:id])
	end

	def import
    end

    def patt_csv_import  
        file = params[:file]  
        CSV.new(file.tempfile, :headers => true).each do |row|
                pattern = Pattern.create!(
                   :name => row[0],  
                   :number => row[2],  
                   :background => row[4],    
                   :challenges => row[5],  
                   :issue => row[6], 
                   :solution => row[7], 
                   :notes => "#{row[1] + "\n" if row[1].present?}#{row[3] if row[3].present?}",
                   :created_at => "#{DateTime.strptime(row[8], "%m/%d/%y") unless row[8].blank? }" || Time.now,
                   :updated_at => "#{DateTime.strptime(row[9], "%m/%d/%y") unless row[9].blank? }" || Time.now
                  )

        end  
        redirect_to contacts_path
    end

	def create
	    @pattern = Pattern.new(params[:pattern])
	    if @pattern.save
	      redirect_to patterns_by_project_path(@pattern.project_id)
	    else
	    	redirect_to patterns_path
	    end
	end

	def edit
	    @pattern = Pattern.find(params[:id])
	end

	def update
	    @pattern = Pattern.find(params[:id])
	    if @pattern.update_attributes(params[:pattern])
	      flash[:success] = "Pattern updated!"
	      redirect_to edit_pattern_path
	    else
	      render 'edit'
	    end
	end

	def destroy
		project_id = Pattern.find(params[:id]).project_id
	    Pattern.find(params[:id]).destroy
	    flash[:success] = "Pattern destroyed."
	    redirect_to patterns_by_project_path(project_id)

	end

end
