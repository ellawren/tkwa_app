class PatternGroupsController < ApplicationController

  def index
	    @pattern_groups = PatternGroup.all
	end

	def show
	    @pattern_group = PatternGroup.find(params[:id])
	end

	def new
	    @pattern_group = PatternGroup.new
	end

	def create
	    @pattern_group = PatternGroup.new(params[:pattern_group])
	    if @pattern_group.save
	      	redirect_to pattern_groups_path
	    else
	      	render 'new'
	    end
	end

	def edit
	    @pattern_group = PatternGroup.find(params[:id])
	end

	def update
	    @pattern_group = PatternGroup.find(params[:id])
	    if @pattern_group.update_attributes(params[:pattern_group])
	      	flash[:success] = "Pattern group updated"
	      	redirect_to pattern_groups_path
	    else
	      	render 'edit'
	    end
	end

	def destroy
	    PatternGroup.find(params[:id]).destroy
	    flash[:success] = "Pattern group destroyed."
	    redirect_to pattern_groups_path
	end

end
