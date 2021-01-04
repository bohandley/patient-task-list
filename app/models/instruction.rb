class Instruction < ApplicationRecord
	belongs_to :patient
	belongs_to :task_list

	has_many :selected_tasks, :dependent => :destroy

	accepts_nested_attributes_for :selected_tasks
end
