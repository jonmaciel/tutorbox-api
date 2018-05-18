organization = Organization.create!(name: 'First Organization')
first_system = System.create!(name: 'First System', organization: organization)

adm = User.create!(name: 'User Admin',email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :admin)
User.create!(name: 'User script writer',email: 'user_script_writer@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :script_writer)
user = User.create!(name: 'User system admin',email: 'user_role_admin2@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :system_admin, system_role_params: [{ first_system.id => 'admin'}], organization: organization)

video = Video.create(title: 'Default Video 1', system: first_system, upload_type: :aws, created_by: user, url: 'video/1/7_7c9f5c7863b70f2b27e1522cc681e195.quicktime')

Comment.create(video: video, author: user, comment_destination: 'administrative', body: 'Comment test')
Task.create(video: video, created_by: user, name: 'Improve ths video')
Attachment.create(source: video, source_type: Video, created_by: user, url: '/fake/url')

organization = Organization.create!(name: 'Tutorbox')
User.create!(name: 'Jon',email: 'joaomaciel.n@mail.com' , password: '123123123' , password_confirmation: '123123123', user_role: :admin, organization: organization)


VideoNotification.create!(video: video, user: adm, body: 'Testing 1')
VideoNotification.create!(video: video, user: user, body: 'Testing 2')