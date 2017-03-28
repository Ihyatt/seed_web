module RailsAdmin::IncidentAdmin
	extend ActiveSupport::Concern

	included do
		rails_admin do
		    include_all_fields
    		field :metadata, :string
  		end
	end
end
