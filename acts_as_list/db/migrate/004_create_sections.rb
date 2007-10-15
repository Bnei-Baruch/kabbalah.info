class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections, :force => true do |t|
      t.column :title, :string
      t.column :description, :text
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :sections
  end
end
