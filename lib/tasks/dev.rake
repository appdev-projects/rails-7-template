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

  usernames = ["Alice Johnson", "Bob Smith", "Carol Davis", "Dave Brown", "Eve Wilson"]

  usernames.each do |username|

    user = User.new
    user.email = "#{username.split.first.downcase}@example.com"
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

  subjects = [
    "Cat sneezing",
    "Fur loss",
    "Not eating",
    "Odd behavior",
    "Lump on back"
  ]

  contents = [
    "My cat has been sneezing frequently. Should I be worried?",
    "I've noticed patches of fur missing on my cat's back and I'm concerned.",
    "My cat hasn't eaten or drunk anything in the past 24 hours. What should I do?",
    "Lately, my cat has been hiding and acting lethargic. Is this something I should be concerned about?",
    "I found a small lump on my cat's back while petting her. Should I take her to the vet?",
    "My cat has been sneezing on and off for a few days now.",
    "There are patches of fur missing on my cat. What could be the reason?",
    "My cat has refused to eat or drink for a whole day now.",
    "I've noticed some odd behavior from my cat recently. She's been hiding a lot.",
    "While petting my cat, I discovered a lump on her back."
  ]

  details = [
    "My cat has been sneezing frequently for the past few days. Should I be worried? I've tried changing her environment and cleaning her bedding, but it hasn't helped. I'm not sure if this is a sign of allergies or something more serious. I haven't noticed any other symptoms, but I'm worried it might be an infection or some kind of respiratory issue. She seems fine otherwise, but the sneezing is persistent. Could this be due to a change in weather or is it possible she's allergic to something in our home?",
    "I've noticed patches of fur missing on my cat's back. She doesn't seem to be in any pain, but I'm concerned it might be a skin condition or an allergy. I've checked for fleas and other parasites but didn't find anything. Could it be stress-related, or should I consider changing her diet? I've also read that certain medical conditions can cause fur loss, and I'm wondering if I should take her to the vet to get checked out. Has anyone else experienced this with their cat?",
    "My cat hasn't eaten or drunk anything in the past 24 hours. She usually has a good appetite, so this sudden change is worrying me. I've tried offering her different types of food, but she shows no interest. Could it be stress, or should I be looking for other symptoms like vomiting or diarrhea? I'm considering taking her to the vet, but wanted to see if anyone else has had a similar experience and what the outcome was. She seems a bit lethargic but otherwise okay.",
    "Lately, my cat has been hiding and acting lethargic. She's usually very active and social, so this behavior is quite unusual for her. I'm wondering if it could be a sign of illness or if there's something in the environment that's bothering her. Should I take her to the vet for a check-up? I've noticed she's also been eating less and sleeping more. Could this be a sign of a more serious underlying issue? Any advice would be greatly appreciated.",
    "I found a small lump on my cat's back while petting her. It doesn't seem to be bothering her, but I'm not sure if it's something that needs immediate attention or if it's harmless. The lump is about the size of a pea and feels firm to the touch. Could it be a cyst or a tumor? Has anyone else found lumps on their cats, and what was the outcome? I'm planning to take her to the vet, but wanted to get some input first to know what to expect. She seems perfectly healthy otherwise."
  ]

  10.times do
    post = Post.new
    post.subject = subjects.sample
    post.content = contents.sample
    post.details = details.sample
    post.image = images.sample
    post.user_id = User.all.sample.id
    post.save

    reply_contents = [
      "It could be a sign of allergies. Maybe try changing the cat litter or food and see if that helps.",
      "Hair loss can be caused by a number of things including stress or a skin condition. It's best to consult a vet.",
      "Loss of appetite can be a serious issue. I'd recommend taking your cat to the vet as soon as possible.",
      "Some cats go through phases of odd behavior, but it's always good to rule out any medical issues with a vet visit.",
      "Lumps can sometimes be benign, but it's important to have them checked out by a vet to be sure."
    ]

    10.times do
      reply = Reply.new
      reply.user_id = User.all.sample.id
      reply.post_id = post.id
      reply.content = reply_contents.sample
      reply.save
    end
  end

  puts "There are now #{User.count} rows in the users table."
  puts "There are now #{Post.count} rows in the posts table."
  puts "There are now #{Reply.count} rows in the replies table."
end
