class AvailabilitySerializer < ActiveModel::Serializer
  attributes (
    :id,
    :start,
    :end,
    :created_at, 
    :updated_at
  )
  belongs_to(:teacher, key: :teacher)
end
