class AddReviewStatusCheckersForReviewModel < ActiveRecord::Migration[5.1]
  def up
    add_column :reviews, :musician_reviewed, :boolean, :default => false
    add_column :reviews, :client_reviewed, :boolean, :default => false
  end

  def down
    remove_column :reviews, :client_reviewed, :boolean
    remove_column :reviews, :musician_reviewed, :boolean
  end
end
