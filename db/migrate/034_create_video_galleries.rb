class CreateVideoGalleries < ActiveRecord::Migration
  def self.up
    create_table :video_galleries do |t|
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :video_galleries
  end
end
