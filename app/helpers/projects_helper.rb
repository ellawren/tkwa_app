module ProjectsHelper


  	def list_roles(consultant, project)
  		roles_count = ConsultantTeam.count(:all, 
  			:conditions => [ "consultant_id = #{consultant} AND project_id = #{project}" ] )
  		roles_all = ConsultantTeam.find(:all, :select => "consultant_role", :conditions => [ "consultant_id = #{consultant} AND project_id = #{project}" ] ).map{ |r| r.consultant_role }
  		if roles_count >= 3
			roles_all.join(', ')
		elsif roles_count = 2
			roles_all.join(' + ')
		else
			roles_all
		end	
  	end


end
