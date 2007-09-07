ActionController::Routing::Routes.draw do |map|

  map.home 'engkab', :controller => 'sessions', :action => 'new'

  # Authentication system
  map.resources :users
  map.resource :session, :controller => 'sessions'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'




  map.resources :engkab, :controller => 'engkab',
  											 :singular => 'engkab_page'

  map.resources :pages
  map.resources :assets
  map.resources :sections
  map.resources :categories
  map.resources :videos

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  map.section0 ':section/:id', :action => 'show', :controller => 'engkab' 
  map.section1 ':section/:category0/:id', :action => 'show', :controller => 'engkab' 
  map.section2 ':section/:category0/:category1/:id', :action => 'show', :controller => 'engkab' 
  # This route can be invoked with test1_url(:id => asset, :section => asse)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:id'
  map.connect ':controller/:section/:id', :action => 'show'
  map.connect ':controller/:section/:category1/:id', :action => 'show'



end
