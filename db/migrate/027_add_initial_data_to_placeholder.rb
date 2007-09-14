class AddInitialDataToPlaceholder < ActiveRecord::Migration
  def self.up
    main_placeholder = Placeholder.main_placeholder
    right_box_placeholder = Placeholder.right_box_placeholder
    main_placeholder_params 		 = {:name => "Main Content",
    																:permitted_assets => "article video"}
    right_box_placeholder_params = {:name => "Right Box",
    																:permitted_assets => "article"}
		
		if main_placeholder
			main_placeholder.update_attributes( main_placeholder_params )
    else
    	Placeholder.create( main_placeholder_params )
  	end

		if right_box_placeholder
			right_box_placeholder.update_attributes( right_box_placeholder_params )
    else
    	Placeholder.create( right_box_placeholder_params )
  	end

		

  end

  def self.down
  end
end
