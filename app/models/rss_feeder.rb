require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'yaml'

class RssFeeder < ActiveRecord::Base
	acts_as_asset
	before_save :update_rss

	def items
		rss_items = YAML.load(self.data)
		result = []
		rss_items.each do |rss_item|
			result << {:title =>rss_item.title, :url => rss_item.guid.content}
		end
		return result
	end

	def update_rss
		@@was_here ||= false
		return if @@was_here
		@@was_here = true

		content = ''
		open(self.url) { |f|
			content = f.read
		}
		data = YAML.dump(RSS::Parser.parse(content, false).items[0...self.number_of_items])
		self.update_attributes(:data => data)
	end
	
	# 0 1,4,7,10,13,16,19,22 * * * (cd /sites/prod/en_main; ruby script/runner -e production RssFeeder.load_and_store_rss_objects)
	def self.load_and_store_rss_objects
		feeders = RssFeeder.find_all
		return if feeders == nil
		feeders.each { |feeder|
			begin
				feeder.update_rss
			end
		}
	end
end
