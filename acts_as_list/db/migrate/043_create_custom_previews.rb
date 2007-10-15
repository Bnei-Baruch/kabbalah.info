class CreateCustomPreviews < ActiveRecord::Migration
  def self.up
    create_table :custom_previews do |t|
      t.column :inner_title, :string
      t.column :link, :string
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :custom_previews
  end
end
