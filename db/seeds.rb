# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_OF_USERS = 20
PASSWORD = '123'
Like.delete_all()
Comment.delete_all()
Post.delete_all()
User.destroy_all()

super_user = User.create(
  name: 'jon',
  email: 'js@winterfell.gov',
  is_admin: true,
  password: PASSWORD,
  
)

NUM_OF_USERS.times do |x|
  u = User.create({
    name: Faker::Games::SuperSmashBros.fighter,
    email: Faker::Internet.email,
    is_admin: false,
    password: PASSWORD
    
  })
end

users = User.all


100.times do
    created_at = Faker::Date.backward(365 * 5)
    p = Post.create(
      title: Faker::DcComics.title,
      body: Faker::Lorem.sentence(word_count: 50),
      created_at: created_at,
      updated_at: created_at,
    #   # We can use the user instance for the "user" attribute rather than using "user_id"
      user: users.sample,
    )

    if p.valid?
      
        p.comments = rand(0..15).times.map do
          Comment.new(
            body: Faker::GreekPhilosophers.quote,
            user: users.sample,
          )
        end
        p.likers = users.shuffle.slice(0, rand(users.count))
    end
end

puts Cowsay.say("Generated #{Post.count} posts", :koala)
puts Cowsay.say("Generated #{Comment.count} comments", :stegosaurus)
puts Cowsay.say("Created #{users.count}  users!", :turtle)
puts Cowsay.say("Sign in with #{super_user.email} and password: #{PASSWORD}", :cow)