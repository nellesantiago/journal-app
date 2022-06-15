class AddCheckedColumnToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :checked, :boolean
  end
end
