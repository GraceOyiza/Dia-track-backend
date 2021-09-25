class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :username, :image

  has_many :readings
end
