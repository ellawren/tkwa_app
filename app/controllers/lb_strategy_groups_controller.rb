class LbStrategyGroupsController < ApplicationController

	def new
  	    @lb_strategy_group = LbStrategyGroup.new
    end

    def show
  	    @lb_strategy_group = LbStrategyGroup.find(params[:id])
    end

    def edit
  	    @lb_strategy_group = LbStrategyGroup.find(params[:id])
    end

    def index
  	    @lb_strategy_groups = LbStrategyGroup.all
    end

    def create
        @lb_strategy_group = LbStrategyGroup.new(params[:lb_strategy_group])
        if @lb_strategy_group.save
            flash[:success] = "Strategy Group created!"
            redirect_to edit_lb_strategy_group_path(@lb_strategy_group)
        else
            render 'new'
        end
    end

    def update
        @lb_strategy_group = LbStrategyGroup.find(params[:id])
        if @lb_strategy_group.update_attributes(params[:lb_strategy_group])
            flash[:success] = "Strategy Group updated!"
            redirect_to edit_lb_strategy_group_path(@lb_strategy_group)
        else
            render 'edit'
        end
    end

    def destroy
        LbStrategyGroup.find(params[:id]).destroy
        flash[:success] = "Strategy Group destroyed."
        redirect_to lb_strategy_groups_path
    end

end
