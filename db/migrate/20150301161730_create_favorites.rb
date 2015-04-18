class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references  :user
      t.references  :dog
      t.timestamps
    end
  end
end
