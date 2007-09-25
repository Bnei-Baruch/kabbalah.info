# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

# This helper is used in the TOC - if no asset in the page has title the toc shouldn't be shown.
	def has_title?(collection)
		collection ? collection.any?{|asset| !asset.resource.property.title.empty? } : false
	end
#This helper is used in the section preview new and edit. returns a list of sections ready for select tag
	def get_sections
		Section.environments_with_no_homepage.collect{|section| [section.title, section.id.to_s] }.sort
	end
end
