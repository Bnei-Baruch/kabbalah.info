require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class RssFeeder < ActiveRecord::Base
	acts_as_asset

	def items
		rss_items = self.rss_object.items
		result = []
		number_of_items.times do |i|
			result << {:title =>rss_items[i].title, :url => rss_items[i].guid.content}
		end
		return result
	end

	def rss_object
		source = self.url
		content = "" # raw content of rss feed will be loaded here
		open(source) do |s| content = s.read end
		RSS::Parser.parse(content, false)
	end
end
