class TagsController < ApplicationController
  	def index
  	    @tags = Tag.all
    end

    def edit
        @tag = Tag.find(params[:id])
    end

    def new
        @tag = Tag.new
    end

    def update
        @tag = Tag.find(params[:id])
        if @tag.update_attributes(params[:tag])
            flash[:success] = "Tag updated!"
            redirect_to tags_path
        else
            render 'edit'
        end
    end

    def destroy
        Tag.find(params[:id]).destroy
        flash[:success] = "Tag destroyed."
        redirect_to tags_path
    end
end
