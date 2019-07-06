class TeacherLanguage < ApplicationRecord
  belongs_to :teacher
  belongs_to :language

  validates(:language_id, uniqueness: { scope: :teacher_id })
end
