class ConsultantTeamsController < ApplicationController
 
  	def show
  		@consultant_team = ConsultantTeam.find(params[:id].to_i)
        @bills = Bill.find_all_by_consultant_team_id(@consultant_team_id)
        1.times { @consultant_team.bills.build }
        render :layout => 'modal' 
    end

  	def destroy
	    ConsultantTeam.find(params[:id]).destroy
	    flash[:success] = "Consultant team destroyed."
	    redirect_to(:back) 
  	end

  	def update
        @consultant_team = ConsultantTeam.find(params[:id])
        if @consultant_team.update_attributes(params[:consultant_team])
            redirect_to billing_project_path(Project.find(@consultant_team.project_id))
        else
            redirect_to(:back) 
        end
    end
  
end
