desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  puts "Sample data task running"
  if Rails.env.development?
    User.destroy_all
    Post.destroy_all
    Reply.destroy_all
  end
  if Rails.env.production?
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|

    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.name = username
    user.save

  end

  images = [
    "https://images.fineartamerica.com/images-medium-large-5/serious-cat-square-dog-photography.jpg", 
    "https://pbs.twimg.com/media/EYOq_ZbXsAAYbfN.jpg", 
    "https://previews.123rf.com/images/yommy8008/yommy80081610/yommy8008161000081/67376534-square-photo-with-head-detail-of-few-weeks-old-tabby-cat-kitten-has-blue-eyes-and-dark-nose-baby.jpg", 
    "https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg", 
    "https://mediaproxy.snopes.com/width/1200/height/1200/https://media.snopes.com/2020/10/49535473258_7f77bf6a58_c.jpg"
  ]


  5.times do
    post = Post.new
    post.subject = Faker::Address.community
    post.content = Faker::Address.community
    post.image = images.sample
    post.user_id = User.all.sample.id
    post.save

    5.times do
      reply = Reply.new
      reply.user_id = User.all.sample.id
      reply.post_id = post.id
      reply.content = Faker::Lorem.paragraphs(number: rand(1..5), supplemental: true).join("\n\n")
      reply.save
    end
  end

  puts "There are now #{User.count} rows in the users table."
  puts "There are now #{Post.count} rows in the posts table."
  puts "There are now #{Reply.count} rows in the replies table."
end
