class MeasurementSerializer < ActiveModel::Serializer
  attributes :id, :value, :date, :updated_at
end
