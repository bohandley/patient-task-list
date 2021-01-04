class TaskList < ApplicationRecord
	has_many :task_items, :dependent => :destroy
end
