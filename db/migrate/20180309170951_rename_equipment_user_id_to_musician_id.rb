class RenameEquipmentUserIdToMusicianId < ActiveRecord::Migration[5.1]
  def change
    rename_column :equipment, :user_id, :musician_id
  end
end
