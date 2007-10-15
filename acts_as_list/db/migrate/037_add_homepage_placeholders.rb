class AddHomepagePlaceholders < ActiveRecord::Migration
  def self.up
    homepage_left_placeholder_params 		 = {:name => "Homepage Left",
    																:permitted_assets => "rss_feeder custom section_preview"}
    homepage_right_placeholder_params = {:name => "Homepage Right",
    																:permitted_assets => "rss_feeder custom section_preview"}
		
  	Placeholder.create( homepage_left_placeholder_params )
  	Placeholder.create( homepage_right_placeholder_params )
  end

  def self.down
  end
end
