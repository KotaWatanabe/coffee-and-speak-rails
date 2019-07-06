class Timeslot < ApplicationRecord
    has_many :teacher_timeslots, dependent: :destroy
    has_many :teachers, through: :teacher_timeslots
end
