 require 'open-uri'
require 'json'


User.create(name: "Jessie", email: "jessie@wu.com", username: "jessie", password: "jessie")

User.create(name: "Michelle", email: "michelle@gmail.com", username: "michelle", password: "michelle")


User.create(name: "Andrew", email: "andrew@gmail.com", username: "beard", password: "andrew")


Rating.create(user_id: 1, dog_id: 6, independent: "on", chill:"on", affectionate: "on", comments: "So cute! I love her little tongue sticking out. Sometimes when she sleeps, her tongue gets all dried and shriveled up.", video_url: "https://www.youtube.com/watch?v=9DU9mcMBIGA")

Rating.create(user_id: 2, dog_id: 59, affectionate: "on", chill: "on", independent: "on", comments: "Loves to politely ask for attention by pawing at your hand. He doesn't play much on hot days, but he does like to hang out next to you all day every day.", video_url: "https://www.youtube.com/watch?v=1HE3bZq9ztg")

def parse_dogs_json
  @dog_data = JSON.parse(IO.read('dogsData.json'))
end


# create dog records in our database
def seed_dogs(data)
  # data = @dog_data["collection1"]
  i = 0
  59.times do
    Dog.create(name: data[i]["dog_name"]["text"], breed: data[i]["breed"], image_link: data[i]["image"]["src"], description: Faker::Lorem.paragraph(2), gender: data[i]["gender"], direct_url: data[i]["dog_name"]["href"])
    i+=1
  end
end


def seed_ratings(traits, comments)

  200.times do
   Rating.create(dog_id: rand(55), comments: comments.sample, affectionate: traits.sample, playful: traits.sample, good_with_kids: traits.sample, chill: traits.sample, independent: traits.sample, timid: traits.sample, high_energy: traits.sample)
  end


end

random_traits = ["on", nil]
comments = ["It is so cute when it sleeps!", "It loves to go on long walks.", "It doesn't really like other dogs, it likes all the attention to itself", "It likes to sleep all day", "Aw, my favorite dog to take out for hikes!", "It needs some training with the leash but other than that, it's the perfect dog!", "I want to squeeze it to death...","It snores when it dreams!", "Kinda smelly, but that's okay.", "It has the biggest puppy eyes ever.", "not very smart but really cute.", "Likes to give big sloppy kisses.", "So adorable!", "Really smart. Knows how to sit, shake, lie down, fetch, and play dead.", "Really funny dog who likes to watch tv next to you", "Sloppy eater, sloppy kisses.", "Really fat, likes to steal food when you're not looking."]


200.times do
  Favorite.create(dog_id: rand(55))
end


parse_dogs_json
seed_dogs(@dog_data["collection1"])

seed_ratings(random_traits, comments)

