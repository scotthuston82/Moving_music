class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :client_id
      t.integer :musician_id
      t.timestamps
    end
  end
end
