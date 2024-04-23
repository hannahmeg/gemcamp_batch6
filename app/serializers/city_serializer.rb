class CitySerializer < ActiveModel::Serializer
  attributes :id

  def province
    object.province.name
  end
end
