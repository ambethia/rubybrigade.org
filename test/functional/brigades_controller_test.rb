require File.dirname(__FILE__) + '/../test_helper'
require 'brigades_controller'

# Re-raise errors caught by the controller.
class BrigadesController; def rescue_action(e) raise e end; end

class BrigadesControllerTest < Test::Unit::TestCase
  fixtures :brigades

  def setup
    @controller = BrigadesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:brigades)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_brigade
    old_count = Brigade.count
    post :create, :brigade => { }
    assert_equal old_count+1, Brigade.count
    
    assert_redirected_to brigade_path(assigns(:brigade))
  end

  def test_should_show_brigade
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_brigade
    put :update, :id => 1, :brigade => { }
    assert_redirected_to brigade_path(assigns(:brigade))
  end
  
  def test_should_destroy_brigade
    old_count = Brigade.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Brigade.count
    
    assert_redirected_to brigades_path
  end
end
