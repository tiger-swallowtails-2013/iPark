class IndexZip < ActiveRecord::Migration
  def change
   add_index :spots, :zip_code
  end
end
