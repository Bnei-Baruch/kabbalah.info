class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages, :force => true do |t|
      t.column :title, :string
      t.column :permalink, :string
      t.column :description, :text
      t.column :keywords, :string
      t.column :is_published, :boolean, :default => false
      t.column :is_hidden, :boolean, :default => false
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :pages
  end
end
