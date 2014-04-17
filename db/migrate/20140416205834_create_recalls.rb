class CreateRecalls < ActiveRecord::Migration
  def change
    create_table :recalls do |t|
      t.integer :user_id
      t.integer :card_id
      t.timestamps
    end
  end
end
