class AddInitialDataToPlaceholder < ActiveRecord::Migration
  def self.up
    main_placeholder_params 		 = {:name => "Main Content",
    																:permitted_assets => "article video"}
    right_box_placeholder_params = {:name => "Right Box",
    																:permitted_assets => "article"}
		
    	Placeholder.create( main_placeholder_params )
    	Placeholder.create( right_box_placeholder_params )

		

  end

  def self.down
  end
end
