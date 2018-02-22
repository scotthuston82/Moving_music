class AddStageNameToUser < ActiveRecord::Migration[5.1]
  def up
    change_table :users do |t|
      t.string :stage_name
    end
  end

  def down
    change_table :users do |t|
      t.remove :stage_name
    end
  end


end
