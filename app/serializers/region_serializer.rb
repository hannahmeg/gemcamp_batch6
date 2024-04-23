class RegionSerializer < ActiveModel::Serializer
  attributes :id, :name

  def region
    object.region.name
  end
end
