class CreateGenresUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :genres_users do |t|
      t.integer :user_id
      t.integer :genre_id
    end
  end
end
