require File.dirname(__FILE__) + '/../test_helper'
require 'rss_feeders_controller'

# Re-raise errors caught by the controller.
class RssFeedersController; def rescue_action(e) raise e end; end

class RssFeedersControllerTest < Test::Unit::TestCase
  fixtures :rss_feeders

  def setup
    @controller = RssFeedersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:rss_feeders)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_rss_feeder
    old_count = RssFeeder.count
    post :create, :rss_feeder => { }
    assert_equal old_count+1, RssFeeder.count
    
    assert_redirected_to rss_feeder_path(assigns(:rss_feeder))
  end

  def test_should_show_rss_feeder
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_rss_feeder
    put :update, :id => 1, :rss_feeder => { }
    assert_redirected_to rss_feeder_path(assigns(:rss_feeder))
  end
  
  def test_should_destroy_rss_feeder
    old_count = RssFeeder.count
    delete :destroy, :id => 1
    assert_equal old_count-1, RssFeeder.count
    
    assert_redirected_to rss_feeders_path
  end
end
