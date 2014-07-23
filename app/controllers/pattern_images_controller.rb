class PatternImagesController < ApplicationController

  	def new
  	    @pattern_image = PatternImage.new
    end

    def show
  	    @pattern_image = PatternImage.find(params[:id])
    end

    def edit
  	    @pattern_image = PatternImage.find(params[:id])
    end

    def index
  	    @pattern_images = PatternImage.all
    end

    def create
        @pattern_image = PatternImage.new(params[:pattern_image])
        if @pattern_image.save
            flash[:success] = "Pattern image created!"
            redirect_to pattern_images_path
        else
            render 'new'
        end
    end

    def update
        @pattern_image = PatternImage.find(params[:id])
        if @pattern_image.update_attributes(params[:pattern_image])
            flash[:success] = "Pattern image updated!"
            redirect_to pattern_images_path
        else
            render 'edit'
        end
    end

    def destroy
        PatternImage.find(params[:id]).destroy
        flash[:success] = "Pattern image destroyed."
        redirect_to pattern_images_path
    end
end
