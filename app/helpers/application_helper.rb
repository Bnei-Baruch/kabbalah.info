# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def get_resource_path_by_asset(asset)
		type = asset.resource_type.downcase
		eval "#{type}_path(asset.resource.id)"
	end
end
