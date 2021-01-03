class AddArchiveToTaskItem < ActiveRecord::Migration[6.0]
  def change
    add_column :task_items, :archive, :boolean
  end
end
