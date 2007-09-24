module PathHelper
	def site_page_url(asset)
		site_page0_url(:section => asset.section, :id => asset.resource )
	end

end
