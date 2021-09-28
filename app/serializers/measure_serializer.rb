class MeasureSerializer < ActiveModel::Serializer
  attributes :id, :title, :goal, :unit

  has_many :measurements
end
