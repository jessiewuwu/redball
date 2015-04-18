class CreateRatings < ActiveRecord::Migration
  def change
    create_table  :ratings do |t|
      t.references  :user
      t.references  :dog
      t.string  :affectionate
      t.string  :independent
      t.string  :playful
      t.string  :timid
      t.string  :good_with_kids
      t.string  :high_energy
      t.string  :chill
      t.text  :comments
      t.string  :video_url
    end
  end
end
