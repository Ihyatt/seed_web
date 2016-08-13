class BaseSerializer < ActiveModel::Serializer
  
  def created_at
    object.created_at.utc.iso8601
  end

  def updated_at
    object.updated_at.utc.iso8601
  end
end