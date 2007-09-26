require 'config'

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
	
#Check field name and comment according to @fields_setup
	def display_field(field, field_for = '', &block)
		id = params[:my_class]
		if id && Config::ASSET.has_key?(id.to_sym)
			fields_setup = Config::ASSET[id.to_sym]
		else
			fields_setup = Config::ASSET[:default]
		end

		if fields_setup.has_key?(field.to_sym)
			field = fields_setup[field]
			return if not (field and field.is_a?(Array))
			label = field[0]
			comment = (field.size > 1 && field[1] != '' )? " <span>(#{field[1]})</span>" : ''
		else
			label = field.to_s
			comment = ''
		end

		field_for = "for=\"#{field_for}\"" if field_for != ''
		"<label #{field_for}>#{label}#{comment}</label>" +
																										if block
																											yield block
																										else
																											''
																										end
	end
end
