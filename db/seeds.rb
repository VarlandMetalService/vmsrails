# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.unscoped.delete_all
toby = User.create first_name: 'Toby', last_name: 'Varland', middle_initial: 'A', avatar_bg_color: '#02779e', avatar_text_color: '#fbb829', email: 'toby.varland@varland.com', is_admin: true, employee_number: 937
toby.update first_name: 'Tobias'
User.create first_name: 'John', last_name: 'McGuire', username: 'johnm', avatar_bg_color: '#000000', avatar_text_color: '#ff0000', email: 'john.mcguire@varland.com', is_admin: true, employee_number: 940
User.create first_name: 'Joel', last_name: 'Perrine', avatar_bg_color: '#ff0000', avatar_text_color: '#ffffff', email: 'joel.perrine@varland.com', is_admin: false, employee_number: 708
User.create first_name: 'Ross', last_name: 'Varland', avatar_bg_color: '#800F25', avatar_text_color: '#FFFC7F', is_admin: false, employee_number: 938
User.create first_name: 'Kevin', last_name: 'Marsh', avatar_bg_color: '#04C4BB', avatar_text_color: '#000000', is_admin: false, employee_number: 928
User.create first_name: 'Art', last_name: 'Mink', suffix: 'III', avatar_bg_color: '#F0D878', avatar_text_color: '#000000', is_admin: false, employee_number: 935
User.create first_name: 'Brian', last_name: 'Mangold', avatar_bg_color: '#556270', avatar_text_color: '#ffffff', is_admin: false, employee_number: 939
User.create first_name: 'Rich', last_name: 'Branson', avatar_bg_color: '#303030', avatar_text_color: '#CCFF00', is_admin: false, employee_number: 707
User.create first_name: 'Dom', last_name: 'Aracri', avatar_bg_color: '#ff0000', avatar_text_color: '#000000', is_admin: false, employee_number: 834
User.create first_name: 'Kelly', last_name: 'Smith', avatar_bg_color: '#9D2053', avatar_text_color: '#ffffff', is_admin: false, employee_number: 827
User.create first_name: 'Gail', last_name: 'Krauser', avatar_bg_color: '#7FAF1B', avatar_text_color: '#ffffff', is_admin: false, employee_number: 811
User.create first_name: 'Greg', last_name: 'Turner', avatar_bg_color: '#327CCB', avatar_text_color: '#ffffff', is_admin: false, employee_number: 603