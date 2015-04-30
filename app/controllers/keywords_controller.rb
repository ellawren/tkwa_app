class KeywordsController < ApplicationController
  def new
  	    @keyword = Keyword.new
    end

    def show
  	    @keyword = Keyword.find(params[:id])
    end

    def edit
  	    @keyword = Keyword.find(params[:id])
    end

    def index
  	    @keywords = Keyword.all
    end

    def create
        @keyword = Keyword.new(params[:keyword])
        if @keyword.save
            flash[:success] = "Keyword created!"
            redirect_to keywords_path
        else
            render 'new'
        end
    end

    def update
        @keyword = Keyword.find(params[:id])
        if @keyword.update_attributes(params[:keyword])
            flash[:success] = "Keyword updated!"
            redirect_to keywords_path
        else
            render 'edit'
        end
    end

    def destroy
        Keyword.find(params[:id]).destroy
        flash[:success] = "Keyword destroyed."
        redirect_to keywords_path
    end
end
