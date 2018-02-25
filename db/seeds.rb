organization = Organization.create!(name: 'First Organization')
first_system = System.create!(name: 'First System', organization: organization)

User.create!(name: 'User Admin',email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :admin, organization: organization)
User.create!(name: 'User script writer',email: 'user_role_admin@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :script_writer, organization: organization)
User.create!(name: 'User system admin',email: 'user_role_admin@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :system_admin, system_role_params: [{ first_system.id => 'admin'}], organization: organization)


organization = Organization.create!(name: 'Tutorbox')
User.create!(name: 'Jon',email: 'joaomaciel.n@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :admin, organization: organization)
