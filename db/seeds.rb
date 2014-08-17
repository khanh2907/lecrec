def set_role(email, role)
  user = User.find_by_email(email)
  role = Role.find_by_name(role)
  user.roles << role
  user.save!
end

Role.delete_all
Role.create!(:name => "Administrator")
Role.create!(:name => "Student")
Role.create!(:name => "Tutor")
Role.create!(:name => "Lecturer")
puts 'CREATED ROLES'

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
set_role(user.email, "Administrator")
