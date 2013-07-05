class ConsultantTeamsController < ApplicationController
 
  def destroy
    ConsultantTeam.find(params[:id]).destroy
    flash[:success] = "Consultant team destroyed."
    redirect_to(:back) 
  end
  
end
