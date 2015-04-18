class CreateDogs < ActiveRecord::Migration
  def change
    create_table  :dogs  do |t|
      t.string  :name
      t.string  :breed
      t.string  :gender
      t.text  :description
      t.string  :image_link
      t.string  :direct_url
      t.timestamps
    end
  end
end
