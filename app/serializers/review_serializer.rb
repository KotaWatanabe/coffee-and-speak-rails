class ReviewSerializer < ActiveModel::Serializer
  attributes (
    :id,
    :body,
    :rating,
    :created_at, 
    :updated_at
  )

  belongs_to(:user, key: :student)
  belongs_to(:teacher, key: :teacher)
end
