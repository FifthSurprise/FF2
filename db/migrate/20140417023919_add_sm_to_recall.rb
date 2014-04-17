class AddSmToRecall < ActiveRecord::Migration
  def change
    add_column :recalls,:easiness_factor, :decimal
    add_column :recalls,:quality_of_last_recall, :integer
    add_column :recalls,:repetition_interval, :integer
    add_column :recalls,:number_repetitions, :integer
    add_column :recalls,:next_repetition, :datetime
    add_column :recalls,:last_studied, :datetime
  end
end
