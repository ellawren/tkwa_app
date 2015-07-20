class FirmsController < ApplicationController

  def index
        @firms = Firm.all
    end

    def new
        @firm = Firm.new
    end

    def create
        @firm = Firm.new(params[:firm])
        if @firm.save
            redirect_to firms_path
        else
            render 'new'
        end
    end

    def edit
        @firm = Firm.find(params[:id])
    end

    def update
        @firm = Firm.find(params[:id])
        if @firm.update_attributes(params[:firm])
            flash[:success] = "Firm updated"
            redirect_to firms_path
        else
            render 'edit'
        end
    end

    def destroy
        Firm.find(params[:id]).destroy
        flash[:success] = "Firm destroyed."
        redirect_to firms_path
    end

end
