require File.dirname(__FILE__) + '/../test_helper'
require 'community_controller'

# Re-raise errors caught by the controller.
class CommunityController; def rescue_action(e) raise e end; end

class CommunityControllerTest < Test::Unit::TestCase
  fixtures :users
  fixtures :specs
  fixtures :faqs
  
  def setup
    @controller = CommunityController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_search_success
    get :search, :q => "*"
    assert_response :success
    assert_tag "p", :content => /Found 13 matches./
    assert_tag "p", :content => /Displaying users 1&ndash;10./
  end
end
