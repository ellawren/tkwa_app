# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



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




