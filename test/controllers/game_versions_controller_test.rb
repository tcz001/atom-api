require 'test_helper'

class GameVersionsControllerTest < ActionController::TestCase
  setup do
    @game_version = game_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_version" do
    assert_difference('GameVersion.count') do
      post :create, game_version: { game_id: @game_version.game_id, language: @game_version.language, version: @game_version.version }
    end

    assert_redirected_to game_version_path(assigns(:game_version))
  end

  test "should show game_version" do
    get :show, id: @game_version
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_version
    assert_response :success
  end

  test "should update game_version" do
    patch :update, id: @game_version, game_version: { game_id: @game_version.game_id, language: @game_version.language, version: @game_version.version }
    assert_redirected_to game_version_path(assigns(:game_version))
  end

  test "should destroy game_version" do
    assert_difference('GameVersion.count', -1) do
      delete :destroy, id: @game_version
    end

    assert_redirected_to game_versions_path
  end
end
