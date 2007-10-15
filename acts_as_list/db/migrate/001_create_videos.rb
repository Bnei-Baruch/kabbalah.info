class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos, :force => true do |t|
      t.column :title, :string
      t.column :category_id, :integer 
      t.column :short_description, :text
      t.column :thumbnail, :binary 
      t.column :video_link, :string 
      t.column :description, :text 
      t.column :transcript, :text 
      t.column :is_featured, :boolean 
      t.column :in_frontpage, :boolean

      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :videos
  end
end
