# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.delete_all

Post.delete_all

100.times do
    created_at = Faker::Date.backward(365 * 5)
    p = Post.create(
      title: Faker::DcComics.title,
      body: Faker::Lorem.sentence(word_count: 50),
      created_at: created_at,
      updated_at: created_at,
    #   # We can use the user instance for the "user" attribute rather than using "user_id"
    #   user: users.sample,
    )

    if p.valid?
      
        p.comments = rand(0..15).times.map do
          Comment.new(
            body: Faker::GreekPhilosophers.quote,
            # user: users.sample,
          )
        end
    end
end

puts Cowsay.say("Generated #{Post.count} posts", :koala)
puts Cowsay.say("Generated #{Comment.count} comments", :stegosaurus)