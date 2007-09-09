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
  
  def test_should_ensure_domain_for_index
    @request.host = "paintitred.railsrumble.com"
    get :index
    assert_response :redirect
    assert_redirected_to "http://rubybrigade.org/"
  end
  
  def test_should_find_brigade_by_subdomain_slug_and_redirect_to_show
    @request.host = "tampa.rubybrigade.org"
    get :index
    assert_response :redirect
    assert_redirected_to "http://rubybrigade.org/brigades/#{brigades(:tampa).id}"
  end

  def test_should_find_brigade_by_geocoding_subdomain_and_redirect_to_show
    mock_geocode_success '33604'
    
    @request.host = "33604.rubybrigade.org"
    get :index
    assert_response :redirect
    assert_redirected_to "http://rubybrigade.org/brigades/#{brigades(:tampa).id}"
  end

  def test_should_find_show_no_brigades_if_geocoding_subdomain_fails
    bad_location = "asdfasdfasdf"
    mock_geocode_failure bad_location
    
    @request.host = "#{bad_location}.rubybrigade.org"
    get :index
    assert_response :success
    brigades = assigns(:brigades)
    assert_equal 0, brigades.length
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_brigade
    mock_geocode_success "St Petersburg"

    old_count = Brigade.count
    post :create, :brigade => { :name => "St. Pete Ruby Brigade", :city => "St Petersburg" }
    assert_equal old_count+1, Brigade.count
    
    assert_redirected_to brigade_path(assigns(:brigade))
  end

  def test_should_not_create_brigade_when_no_name_is_entered
    mock_geocode_success "St Petersburg"

    old_count = Brigade.count
    post :create, :brigade => { :city => "St Petersburg" }
    assert_equal old_count, Brigade.count
    
    assert_response :success
    assert_template 'new'
    brigade = assigns(:brigade)
    assert brigade.errors.length > 0
  end

  def test_should_show_brigade
    get :show, :id => 1
    assert_response :success
  end
  
  def test_should_disallow_subdomain_for_show
    @request.host = "tampa.rubybrigade.org"
    get :show, :id => 1
    assert_response :redirect
    assert_redirected_to "http://rubybrigade.org/brigades/1"
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_brigade
    put :update, :id => 1, :brigade => { }
    assert_redirected_to brigade_path(assigns(:brigade))
  end
  
  def test_should_not_update_brigade_when_name_is_blank
    put :update, :id => 1, :brigade => { :name => '' }
    
    assert_response :success
    assert_template 'edit'
    brigade = assigns(:brigade)
    assert brigade.errors.length > 0
  end
  
  
  def test_should_destroy_brigade
    old_count = Brigade.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Brigade.count
    
    assert_redirected_to brigades_path
  end
  
  def test_should_not_destroy_brigade_when_verify_recaptcha_fails
    @controller.expects(:verify_recaptcha).returns(false)
    delete :destroy, :id => 1
    assert_response :success
    assert_equal "Recaptcha was incorrect", flash[:notice]
  end
  
end
