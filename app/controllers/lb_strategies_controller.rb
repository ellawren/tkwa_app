class LbStrategiesController < ApplicationController

	def new
  	    @lb_strategy = LbStrategy.new
    end

    def show
  	    @lb_strategy = LbStrategy.find(params[:id])
    end

    def edit
  	    @lb_strategy = LbStrategy.find(params[:id])
    end

    def index
  	    @lb_strategies = LbStrategy.all
    end

    def create
        @lb_strategy = LbStrategy.new(params[:lb_strategy])
        if @lb_strategy.save
            flash[:success] = "Strategy created!"
            redirect_to edit_lb_strategy_path(@lb_strategy)
        else
            render 'new'
        end
    end

    def update
        @lb_strategy = LbStrategy.find(params[:id])
        if @lb_strategy.update_attributes(params[:lb_strategy])
            flash[:success] = "Strategy updated!"
            redirect_to edit_lb_strategy_path(@lb_strategy)
        else
            render 'edit'
        end
    end

    def destroy
        LbStrategy.find(params[:id]).destroy
        flash[:success] = "Strategy destroyed."
        redirect_to lb_strategies_path
    end

end
