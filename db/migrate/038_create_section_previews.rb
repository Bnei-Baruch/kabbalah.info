class CreateSectionPreviews < ActiveRecord::Migration
  def self.up
    create_table :section_previews do |t|
      t.column :number_of_items, :integer
			t.column :section_id, :integer
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :section_previews
  end
end
