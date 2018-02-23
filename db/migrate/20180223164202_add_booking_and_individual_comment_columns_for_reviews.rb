class AddBookingAndIndividualCommentColumnsForReviews < ActiveRecord::Migration[5.1]
  def up
    add_column :reviews, :booking_id, :integer
    add_column :reviews, :musicians_review, :text
    add_column :reviews, :clients_review, :text
    remove_column :reviews, :comment, :text
  end

  def down
    remove_column :reviews, :booking_id, :integer
    remove_column :reviews, :musicians_review, :text
    remove_column :reviews, :clients_review, :text
    add_column :reviews, :comment, :text
  end
end
