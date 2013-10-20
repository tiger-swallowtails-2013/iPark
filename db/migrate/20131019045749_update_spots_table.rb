class UpdateSpotsTable < ActiveRecord::Migration
  def change
    add_column :spots, :start_date, :text
    add_column :spots, :end_date, :text
  end
end
