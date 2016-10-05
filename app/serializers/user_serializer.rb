class UserSerializer < BaseSerializer
  attributes :id, :uid, :facebook_id, :created_at, :updated_at, :race_id, :gender_id, :birthday

  def birthday
    object.birthday.iso8601 if object.birthday
  end
  
end
