ActionController::Routing::Routes.draw do |map|
  map.resources :articles




  # Authentication system
  map.resources :users, :path_prefix => '/admin'
  map.resource :session, :controller => 'sessions', :path_prefix => '/admin'
  map.activate '/admin/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.signup '/admin/signup', :controller => 'users', :action => 'new'
  map.login  '/admin/login', :controller => 'sessions', :action => 'new'
  map.logout '/admin/logout', :controller => 'sessions', :action => 'destroy'
  map.login_home '/admin/login', :controller => 'sessions', :action => 'new'



  map.resources :engkab, :controller => 'engkab',
  											 :singular => 'engkab_page'

  map.site_page0 ':controller/:section/:id', :action => 'show'
  # map.section1 ':controller/:section/:category0/:id', :action => 'show'
  # map.section2 ':controller/:section/:category0/:category1/:id', :action => 'show'


  map.resources :pages, :path_prefix => '/admin'
  map.resources :assets, :path_prefix => '/admin'
  map.resources :sections, :path_prefix => '/admin'
  map.resources :categories, :path_prefix => '/admin'
  map.resources :videos, :path_prefix => '/admin'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # This route can be invoked with test1_url(:id => asset, :section => asse)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  # map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  # map.connect ':controller/:action/:id.:format'
  # map.connect ':controller/:id'
  # map.connect ':controller/:section/:id', :action => 'show'
  # map.connect ':controller/:section/:category1/:id', :action => 'show'



end
