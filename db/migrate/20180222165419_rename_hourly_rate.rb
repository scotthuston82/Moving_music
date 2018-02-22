class RenameHourlyRate < ActiveRecord::Migration[5.1]
  def up
    change_table :users do |t|
      t.rename :hourly_rate_in_cents, :hourly_rate
    end
  end

  def down
    change_table :users do |t|
      t.rename :hourly_rate, :hourly_rate_in_cents
    end
  end
end
