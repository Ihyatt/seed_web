class ReactionSerializer < ActiveModel::Serializer
  attributes :id, :name, :positive, :position
end
