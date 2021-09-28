class MeasureSerializer < ActiveModel::Serializer
  attributes :id, :title, :goal, :unit, :updated_at

  has_many :measurements
end
