require 'config'

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # This helper is used in the TOC - if no asset in the page has title the toc shouldn't be shown.
	def has_title?(collection)
		collection ? collection.any?{|asset| !asset.resource.property.title.empty? } : false
	end
	
  # Load proper configuration according to my_class -- type of an asset resource
  # Check field name (if supplied) to present
	def setup_config(field_to_test = nil)
		id = params[:my_class]
		if id && Config::ASSET.has_key?(id.to_sym)
			fields_setup = Config::ASSET[id.to_sym]
		else
			fields_setup = Config::ASSET[:default]
		end
		
		if field_to_test
			fields_setup.has_key?(field_to_test.to_sym) ? (fields_setup[field_to_test.to_sym] != nil) : nil
		else
			fields_setup
		end
	end
	
  #Check field name and comment according to setup
  #Field is index to Config::ASSET (lib/config.rb)
	def display_field(field, field_for = '', &block)

		fields_setup = setup_config()
		if fields_setup.has_key?(field.to_sym)
			field = fields_setup[field]
			return if not (field and field.is_a?(Array))
			label = field[0]
			comment = (field.size > 1 && field[1] != '' )? " <span>(#{field[1]})</span>" : ''
		else
			label = field.to_s
			comment = ''
		end

		field_for = "for=\"#{field_for}\"" if field_for != ''
		"<label #{field_for}>#{label}#{comment}</label>" +
      if block
      yield block
    else
      ''
    end
	end
  
  
  # YUI interface helpers
  # 

  # <div id="doc2" class="yui-t2">
  def yui_doc(options, &block)
    if !block_given?
      raise "yui_doc: Must have a block!!!"
    end
    doc = options[:doc] || "doc2"             # 950 centered
    template = options[:template] || "yui-t7" # One full-width column
    concat(content_tag("div", capture(&block), :id => doc, :class => template), block.binding)
  end
  
  # Parameters:
  #
  #   Required:
  #   block   - if :yield is empty then this block value
  #             will be evaluated
  #   
  #   Optional:
  #   :yield - Symbol consisting of a value to be output,
  #            will be used instead of block's value
  #   :primary - mark the div as primary block
  #           default: false
  #
  def yui_block(options = {}, &block)
    yield_variable = options[:yield] || nil
    if !block_given? and yield_variable.eql?(nil)
      raise "yui_block: Must have a block or a yield variable!!!"
    end
    
    block_content = if yield_variable
      instance_variable_get "@content_for_#{yield_variable}"
    elsif block_given?
      capture(&block)
    else
      ""
    end
    content = content_tag("div", block_content, :class => "yui-b")
    if options[:primary]
      content = content_tag("div", content, :id => "yui-main")
    end
    concat(content, block.binding)
  end

  # Parameters:
  #
  #   Optional:
  #   :grid - which grid to use (the right part of yui-gf, i.e. "gf"),
  #           default: "g"
  #           note: to use it with additional class: "gf another-class"
  #   :id   - id of div
  #           default: none
  #
  def yui_grid(options = {}, &block)
    if !block_given?
      raise "yui_grid: Must have a block!!!"
    end
    grid = "yui-#{options[:grid] || "g"}"
    id = options[:id] || nil
    content = content_tag("div", capture(&block), :class => grid, :id => id)
    concat(content, block.binding)
  end

  # Parameters:
  #
  #   Required:
  #   block   - if :yield is empty then this block value
  #             will be evaluated
  #   
  #   Optional:
  #   :yield - Symbol consisting of a value to be output,
  #            will be used instead of block's value
  #   :unit - to use it with additional class: "u another-class"
  #           default: "u"
  #   :id   - id of div
  #           default: none
  #
  def yui_unit(options = {}, &block)
    yield_variable = options[:yield] || nil
    if !block_given? and yield_variable.eql?(nil)
      raise "yui_unit: Must have a block or a yield variable!!!"
    end

    unit = "yui-#{options[:unit] || "u"}"
    id = options[:id] || nil
    
    block_content = if yield_variable
      instance_variable_get "@content_for_#{yield_variable}"
    elsif block_given?
      capture(&block)
    else
      ""
    end
    content = content_tag("div", block_content, :class => unit, :id => id)
    concat(content, block.binding)
  end

  # Renders all partials and afterwards block (if supplied)
  # 
  # Either must have block or to use <%=
  # 
  # Parameters:
  #
  #   Optional:
  #   :partials - array of partials to render
  #   :id   - id of div
  #           default: none
  #
  def yui_render(options = {}, &block)
    partials = options.delete(:partials) || []
    id = options.delete(:id)

    content = ""
    partials.each {|partial|
      content << render(options.merge({:partial => partial}))
    }
    content << capture(&block) if block_given?

    content = content_tag("div", content, :id => id) if id
    concat(content, block.binding) if block_given?
    content
  end

  def box_with_shadow(with_border = true, &block)
    if !block_given?
      raise "box_with_shadow: Must have a block!!!"
    end
    
    top = <<-TOP
      <div class="bg-top-middle"><div class="bg-top-left">&nbsp;</div><div class="bg-top-right">&nbsp;</div></div>
      <div class="bg-middle-left">
        <div class="bg-middle-right">
    TOP

    if with_border
      bottom = <<-BOTTOM
            <div class="hd-border">&nbsp;</div>
          </div>
        </div>
      BOTTOM
    else
      bottom = <<-BOTTOM
          </div>
        </div>
        <div class="bg-bottom-middle"><div class="bg-bottom-left">&nbsp;</div><div class="bg-bottom-right">&nbsp;</div></div>
      BOTTOM
    end
    
    content = capture(&block)
    concat(top + content + bottom, block.binding)
  end

end
