class ReadingSerializer < ActiveModel::Serializer
  attributes :id, :fasting, :after_meal, :bp, :date
end
