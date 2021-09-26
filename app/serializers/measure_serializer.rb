class MeasureSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :measurements
end
