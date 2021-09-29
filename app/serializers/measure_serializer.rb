class MeasureSerializer < ActiveModel::Serializer
  attributes :id, :title, :goal, :unit, :date_created

  has_many :measurements
end
