class Patient < ApplicationRecord
	has_many :instructions, :dependent => :destroy
	has_many :task_lists, :through => :instructions
end
