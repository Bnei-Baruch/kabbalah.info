class CreateBannersSectionsTable < ActiveRecord::Migration
	def self.up
		create_table :banners_sections, :id => false do |t|
			t.column :banner_id, :integer
			t.column :section_id, :integer
		end
		
		add_index :banners_sections, :banner_id
		add_index :banners_sections, :section_id
	
	end
	
	def self.down
		drop_table :banners_sections
	end
end
