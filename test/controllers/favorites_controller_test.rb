require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get favorites_show_url
    assert_response :success
  end

  test "should get add_to_favorite" do
    get favorites_add_to_favorite_url
    assert_response :success
  end

end
