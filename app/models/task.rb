class Task < ApplicationRecord
    validates :task, presence: true
    validates :due_date, presence: true
    validates :status, presence: true
end