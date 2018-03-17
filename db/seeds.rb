organization = Organization.create!(name: 'First Organization')
first_system = System.create!(name: 'First System', organization: organization)

User.create!(name: 'User Admin',email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :admin, organization: organization)
User.create!(name: 'User script writer',email: 'user_role_admin@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :script_writer, organization: organization)
user = User.create!(name: 'User system admin',email: 'user_role_admin@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :system_admin, system_role_params: [{ first_system.id => 'admin'}], organization: organization)

video = Video.create(title: 'Default Video 1', system: first_system, created_by: user, url: 'https://media.w3.org/2010/05/sintel/trailer_hd.mp4')
Comment.create(video: video, author: user, comment_destination: 'administrative', body: 'Comment test')
Task.create(video: video, created_by: user, name: 'Improve ths video')

organization = Organization.create!(name: 'Tutorbox')
User.create!(name: 'Jon',email: 'joaomaciel.n@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :admin, organization: organization)
