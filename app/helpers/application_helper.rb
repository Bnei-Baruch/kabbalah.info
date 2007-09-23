# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

# This helper is used in the TOC - if no asset in the page has title the toc shouldn't be shown.
	def has_title?(collection)
		collection.any?{|asset| !asset.resource.property.title.empty? }
	end
end
