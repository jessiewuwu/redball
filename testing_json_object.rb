require 'open-uri'
require 'json'
require 'faker'

def parse_dogs_json
  @dog_data = JSON.parse(IO.read('dogsData.json'))
end


# create dog records in our database
def seed_dogs(data)
  # data = @dog_data["collection1"]

  i = 0
  59.times do
    Dog.create(name: data[i]["dog_name"]["text"], breed: data[i]["breed"], image_link: data[i]["image"]["src"], description: Faker::Lorem.sentence, gender: data[i]["gender"])
    i+=1
  end

  # data[0]["dog_name"]["text"] #"Alfred"
  # data[0]["breed"]
  # data.map do | dog |
  #   @dog_name_string_array = dog["dog_name"]["text"]
  #   @dog_breed_array = dog["breed"]
  #   @dog_gender_array = dog["gender"]
  #   @dog_image_link_array = dog["image"]["src"]

  #   # Dog.create(name: dog_name_string )
  # end


end

p parse_dogs_json
# p seed_dogs(@dog_data["collection1"])

#@dog_data["collection1"] gives us an array with a hash per dog
# [i]["dog_name"]["text"]

