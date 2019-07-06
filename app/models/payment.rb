class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  belongs_to :lesson
end

# belongs_to :sender, class_name: 'User', foreign_key: :sender_id
# belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
