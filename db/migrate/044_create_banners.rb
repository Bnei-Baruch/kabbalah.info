class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.column :flash_url, :string
      t.column :image_url, :string
      t.column :target_link, :string
      t.column :publish_date, :timestamp
      t.column :unpublish_date, :timestamp
      t.column :published, :boolean
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :banners
  end
end
