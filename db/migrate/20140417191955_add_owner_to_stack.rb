class AddOwnerToStack < ActiveRecord::Migration
  def change
    add_column :stacks, :owner_id, :integer
  end
end
