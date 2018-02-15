user_role = UserRole.create!(name: :adm)

User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: user_role)