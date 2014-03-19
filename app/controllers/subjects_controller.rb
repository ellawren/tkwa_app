class SubjectsController < ApplicationController

	def new
  	    @subject = Subject.new
    end

    def show
  	    @subject = Subject.find(params[:id])
    end

    def edit
  	    @subject = Subject.find(params[:id])
    end

    def index
  	    @subjects = Subject.all
    end

    def create
        @subject = Subject.new(params[:subject])
        if @subject.save
            flash[:success] = "Subject created!"
            redirect_to subjects_path
        else
            render 'new'
        end
    end

    def update
        @subject = Subject.find(params[:id])
        if @subject.update_attributes(params[:subject])
            flash[:success] = "Subject updated!"
            redirect_to subjects_path
        else
            render 'edit'
        end
    end

    def destroy
        Category.find(params[:id]).destroy
        flash[:success] = "Subject destroyed."
        redirect_to subjects_path
    end

end
