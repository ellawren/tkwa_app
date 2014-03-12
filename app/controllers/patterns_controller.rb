class PatternsController < ApplicationController
	
	def index
	    @q = Pattern.search(params[:q])
	    @patterns = @q.result(:distinct => true)
	    if @patterns.count == 1 
	      redirect_to pattern_path(@patterns.first(params[:id]))
	    else
	      render 'index'
	    end
	end

	def browse
		if params[:id]
			@project_id = Project.find(params[:id]).id
			@patterns = Pattern.find_all_by_project_id(params[:id])
		else
			@project_id = nil
			@patterns = Pattern.all
		end
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

	def create
	    @pattern = Pattern.new(params[:pattern])
	    if @pattern.save
	      render 'edit'
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
	    Pattern.find(params[:id]).destroy
	    flash[:success] = "Pattern destroyed."
	    redirect_to patterns_path
	end

end
