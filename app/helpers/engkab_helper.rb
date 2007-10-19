module EngkabHelper
  # Parameters:
  #
  #   Required:
  #   :id - parent of a sortable element
  #   :section_id - section of a sortable element
  #   :placeholder_id - placeholder of a sortable element
  #
  #   Optional:
  #   :function - function to call to sort elements,
  #               default: sort_by_parent_id_asset_path
  #   any applicable arguments of Sortable, like :tag, :only, etc.
  #
  def make_sortable(options)
    return unless logged_in?

    parent = options.delete(:id) || 0
    section = options.delete(:section_id) || 0
    placeholder = options.delete(:placeholder_id) || 0

    function = options.delete(:function) || "sort_by_parent_id_asset_path"

    id = sort_ul_id(parent, section, placeholder)

    url = self.send(function,
                     :id => parent,
                     :section_id => section,
                     :placeholder_id => placeholder
          ).gsub!(/&amp;/,'&')
    options[:url] = url
    options[:complete] = visual_effect(:highlight,
                         id,
                         :startcolor=>'"#ffff99"',
                         :endcolor=>'"#ffffff"')
    options[:handle] = 'handle'

    (sortable_element id, options).gsub!(/&amp;/,'&')
  end

  # Handle to designage/move sortable elements
  def sort_handler(force = false)
    return unless logged_in?
    return if @is_homepage and (not force)
    '<img class="handle" src="/files/layouts/arrow.gif" alt="" />'
  end
end
