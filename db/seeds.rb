Role.delete_all
Role.create!(:name => "Administrator")
Role.create!(:name => "Tutor")
Role.create!(:name => "Lecturer")
puts 'CREATED ROLES'

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
user.add_role("Administrator")
