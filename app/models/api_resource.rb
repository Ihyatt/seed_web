class APIResource
  include ActiveModel::Serialization

  attr_accessor :status
  attr_accessor :data
  attr_accessor :pagination
  

  def set_pagination(items,scope)
    @pagination = {
      page: items.current_page, 
      total_pages: items.total_pages,
      count: scope.size
    }
  end
  
end