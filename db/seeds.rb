# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


services = Service.create([
							{ service_name: 'Programming' }, 
							{ service_name: 'Pattern Writing - Full' },
							{ service_name: 'Pattern Writing - Outline' },
							{ service_name: 'As-Built Drawings' },
							{ service_name: 'Verification of As-Built Drawings' },
							{ service_name: 'Site Evaluation/Planning' },
							{ service_name: 'Existing Facilities Surveys' },
							{ service_name: 'Master Planning' },
							{ service_name: 'Interior Design' },
							{ service_name: 'FF&E' },
							{ service_name: 'Architectural Renderings' },
							{ service_name: 'Architectural Models' },
							{ service_name: 'Powerpoint Presentations' },
							{ service_name: 'Fundraising Materials' },
							{ service_name: 'Tenant Build-out' },
							{ service_name: 'Coordination of Owner\'s Consultants' },
							{ service_name: 'As-designed Record Drawings' },
							{ service_name: 'As-constructed Record Drawings' },
							{ service_name: 'Assistance in CM Hiring' },
							{ service_name: 'Building Commissioning' },
							{ service_name: 'LEED Certified' },
							{ service_name: 'LEED Silver' },
							{ service_name: 'LEED Gold' },
							{ service_name: 'LEED Platinum' },
							{ service_name: 'Historic Preservation' },
							{ service_name: 'Grant Application Writing' }
		])

reimbursables = Reimbursable.create([
							{ reimbursable_name: 'Reproduction costs (prints, copies, plots)' }, 
							{ reimbursable_name: 'Postage and delivery service fees' }, 
							{ reimbursable_name: 'Long-distance communications' }, 
							{ reimbursable_name: 'Photographic expenses' }, 
							{ reimbursable_name: 'Mileage' }, 
							{ reimbursable_name: 'Travel Expenses' }, 
							{ reimbursable_name: 'Room & Board' }, 
							{ reimbursable_name: 'Cost of permits, regulatory review, and approval/agency fees' }
		])

consultant_roles = ConsultantRole.create([
        { consultant_role_name: 'Specifications' },
        { consultant_role_name: 'Structural' },
        { consultant_role_name: 'HVAC' },
        { consultant_role_name: 'Electrical' },
        { consultant_role_name: 'Plumbing' },
        { consultant_role_name: 'Fire Protection' },
        { consultant_role_name: 'Civil' },
        { consultant_role_name: 'Landscape' },
        { consultant_role_name: 'Cost Estimating' },
        { consultant_role_name: 'Environmental' },
        { consultant_role_name: 'Energy Modeling' },
        { consultant_role_name: 'Liturgical' },
        { consultant_role_name: 'Acoustical' },
        { consultant_role_name: 'Kitchen/Food Service' },
        { consultant_role_name: 'A/V' },
        { consultant_role_name: 'IT' },
        { consultant_role_name: 'Security' },
        { consultant_role_name: 'Exhibit' },
        { consultant_role_name: 'Economic/Business Planning' },
        { consultant_role_name: 'Interpretive Planning' },
        { consultant_role_name: 'Building Commissioning' },
        { consultant_role_name: 'Swimming Pool' }
])

