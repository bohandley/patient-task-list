class SelectedTask < ApplicationRecord
  belongs_to :instruction
  belongs_to :task_item
end
