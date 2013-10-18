class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :spot
      t.string :password_digest
      t.string :password_confirmation
      t.string :email
      t.string :username
      t.timestamps
    end
  end
end
