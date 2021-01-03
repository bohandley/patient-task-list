class Patient < ApplicationRecord
	has_many :instructions
	has_many :task_lists, :through => :instructions
end
