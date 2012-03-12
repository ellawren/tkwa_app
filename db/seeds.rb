# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Service.delete_all
Service.create([
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

Reimbursable.delete_all
Reimbursable.create([
							{ reimbursable_name: 'Reproduction costs (prints, copies, plots)' }, 
							{ reimbursable_name: 'Postage and delivery service fees' }, 
							{ reimbursable_name: 'Long-distance communications' }, 
							{ reimbursable_name: 'Photographic expenses' }, 
							{ reimbursable_name: 'Mileage' }, 
							{ reimbursable_name: 'Travel Expenses' }, 
							{ reimbursable_name: 'Room & Board' }, 
							{ reimbursable_name: 'Cost of permits, regulatory review, and approval/agency fees' }
		])

ConsultantRole.delete_all
ConsultantRole.create([
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

Category.delete_all
Category.create([
        { name: 'Client' },
        { name: 'Marketing' },
        { name: 'Consultant' },
        { name: 'Architect' },
        { name: 'Contractor' },
        { name: 'Supplier' }
])

User.delete_all

admin = User.create([
	{ name: 'Erin Lawrence', email:'elawrence@tkwa.com', password:'123456', password_confirmation:'123456', admin: true,  employee_attributes: { number: '204' } }
])

User.create([
	{ name: 'Tom Kubala', email:'tkubala@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '101' } },
	{ name: 'Allen Washatko', email:'awashatko@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '102' } },
	{ name: 'Vince Micha', email:'vmicha@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '103' } },
	{ name: 'Joel Krueger', email:'jkrueger@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '105' } },
        { name: 'Rich Hepner', email:'rhepner@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '126' } },
        { name: 'Vicki Yurske', email:'vyurske@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '136' } },
        { name: 'Paul Rushing', email:'prushing@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '138' } },
        { name: 'Tim Hansmann', email:'thansmann@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '148' } },
        { name: 'Mark Lefebvre', email:'mlefebvre@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '159' } },
        { name: 'Leta Flom', email:'lflom@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '170' } },
        { name: 'Kirk Lundgren', email:'klundgren@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '173' } },
        { name: 'Ethan Bartos', email:'ebartos@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '176' } },
        { name: 'Wayne Reckard', email:'wreckard@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '188' } },
        { name: 'Justin Racinowski', email:'jracinowski@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '198' } },
        { name: 'Adam Voltz', email:'avoltz@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '205' } },
        { name: 'Ariel Steuer', email:'asteuer@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '208' } },
        { name: 'Donna Weiss', email:'dweiss@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '177' } },
        { name: 'Jim Read', email:'jread@tkwa.com', password:'123456', password_confirmation:'123456', employee_attributes: { number: '106' } }
])



Task.delete_all
Task.create([
        { number: 1, name: "Project Administration" },
        { number: 2, name: "Programming" },
        { number: 3, name: "Building Code / Zoning" },
        { number: 4, name: "Cost/Budget" },
        { number: 5, name: "As Built Drawings" },
        { number: 6, name: "Master Planning / Feasibility" },
        { number: 7, name: "Meetings" },
        { number: 8, name: "Drawings" },
        { number: 9, name: "Finishes, Furnishings + Equipment" },
        { number: 10, name: "Assist in Consultant/CM Hiring" },
        { number: 11, name: "Specs" },
        { number: 12, name: "Submittals to Authorities" },
        { number: 13, name: "Shop Drawings" },
        { number: 14, name: "Site Visits" },
        { number: 15, name: "Site Evaluation/Planning" },
        { number: 16, name: "Punch List" },
        { number: 17, name: "Travel Time" },
        { number: 18, name: "Building Commissioning" },
        { number: 19, name: "Renderings" },
        { number: 20, name: "Models" },
        { number: 22, name: "Consultant Meetings" },
        { number: 23, name: "LEED Documentation" },
        { number: 24, name: "Existing Facility Surveys" },
        { number: 25, name: "Coordinate Owners Consultants" },
        { number: 26, name: "Pattern Writing" },
        { number: 28, name: "Verify As-Built Drawings" },
        { number: 29, name: "As-designed Record Drawings" },
        { number: 30, name: "As-constructed Record Drawings" },
        { number: 31, name: "Grant Writing" },
        { number: 32, name: "Fundraising / Presentation Materials" }
])

Phase.delete_all
Phase.create([
        { name: 'Predesign', number:10, shorthand:'pd', full_name:"Pre-design" },
        { name: 'Schematic', number:20, shorthand:'sd', full_name:"Schematic Design" },
        { name: 'Design Dev', number:30, shorthand:'dd', full_name:"Design Development" },
        { name: 'Const Docs', number:40, shorthand:'cd', full_name:"Construction Documents" },
        { name: 'Bidding', number:50, shorthand:'bid', full_name:"Bidding" },
        { name: 'CCA', number:60, shorthand:'cca', full_name:"Construction Contract Administration" },
        { name: 'Interior', number:65, shorthand:'int', full_name:"Interior Design" },
        { name: 'Historic', number:68, shorthand:'his', full_name:"Historic Preservation" },
        { name: 'Additional', number:70, shorthand:'add', full_name:"Additional Services" }
])


