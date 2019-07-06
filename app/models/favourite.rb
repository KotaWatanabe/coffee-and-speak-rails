class Favourite < ApplicationRecord
  belongs_to :teacher
  belongs_to :user

  validates :teacher_id, uniqueness: { scope: :user_id }

end
