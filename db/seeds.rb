# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Phase.create([
        { name: 'Predesign', number:10, shorthand:'pd', full_name:"Pre-design" },
        { name: 'Schematic', number:20, shorthand:'sd', full_name:"Schematic Design" },
        { name: 'Design Dev', number:30, shorthand:'dd', full_name:"Design Development" },
        { name: 'Const Docs', number:40, shorthand:'cd', full_name:"Construction Documents" },
        { name: 'Bidding', number:50, shorthand:'bid', full_name:"Bidding" },
        { name: 'CCA', number:60, shorthand:'cca', full_name:"Construction Contract Administration" },
        { name: 'Interior', number:65, shorthand:'int', full_name:"Interior Design" },
        { name: 'Historic', number:68, shorthand:'his', full_name:"Historic Preservation" },
        { name: 'Additional', number:10, shorthand:'add', full_name:"Additional Services" }
])


