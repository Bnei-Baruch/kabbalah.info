# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def has_title?(collection)
		collection.any?{|asset| !asset.resource.property.title.empty? }
	end
end
