class ImperativesController < ApplicationController

    def new
  	    @imperative = Imperative.new
    end

    def show
  	    @imperative = Imperative.find(params[:id])
    end

    def edit
  	    @imperative = Imperative.find(params[:id])
    end

    def index
  	    @imperatives = Imperative.all
    end

    def create
        @imperative = Imperative.new(params[:imperative])
        if @imperative.save
            flash[:success] = "Imperative created!"
            redirect_to imperatives_path
        else
            render 'new'
        end
    end

    def update
        @imperative = Imperative.find(params[:id])
        if @imperative.update_attributes(params[:imperative])
            flash[:success] = "Imperative updated!"
            redirect_to imperative_path(@imperative)
        else
            render 'edit'
        end
    end

    def destroy
        Imperative.find(params[:id]).destroy
        flash[:success] = "Imperative destroyed."
        redirect_to imperative_path(@imperative)
    end

end
