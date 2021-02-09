require 'faker'


User.destroy_all
Post.destroy_all
Comment.destroy_all

User.create(username: 'admin', password: 'admin', email: 'admin@admin.com', is_admin: true)
User.create(username: 'test', password: 'test', email: 'test@test.com')

10.times do
    Post.create(title: "#{Faker::ProgrammingLanguage.name} #{Faker::Verb.ing_form} WTF", content: Faker::Hacker.say_something_smart)
end