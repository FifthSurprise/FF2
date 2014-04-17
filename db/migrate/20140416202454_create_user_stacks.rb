class CreateUserStacks < ActiveRecord::Migration
  def change
    create_table :user_stacks do |t|
      t.integer :user_id
      t.integer :stack_id
      t.timestamps
    end
  end
end
