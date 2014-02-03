class BillsController < ApplicationController

    def index
        @bill = Bill.new
        @team_id = params[:consultant_team_id].to_i
        @bills = Bill.find_all_by_consultant_team_id(@team_id)
        @consultant_team = ConsultantTeam.find(@team_id)
        @project = Project.find(@consultant_team.project_id)
        render :layout => 'modal' 
    end

    def create
        @bill = Bill.new(params[:bill])
        if @bill.save
            redirect_to billing_project_path(Project.find(@bill.consultant_team.project_id))
        else
            redirect_to(:back) 
        end
    end

    def update
        @bill = Bill.find(params[:id])
        if @bill.update_attributes(params[:bill])
            redirect_to billing_project_path(Project.find(@bill.consultant_team.project_id))
        else
            redirect_to(:back) 
        end
    end

    def destroy
        Bill.find(params[:id]).destroy
        redirect_to(:back) 
    end

end
