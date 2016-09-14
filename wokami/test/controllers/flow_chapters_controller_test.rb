require 'test_helper'

class FlowChaptersControllerTest < ActionController::TestCase
  setup do
    @flow_chapter = flow_chapters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flow_chapters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flow_chapter" do
    assert_difference('FlowChapter.count') do
      post :create, flow_chapter: { chapter_id: @flow_chapter.chapter_id, flow_id: @flow_chapter.flow_id }
    end

    assert_redirected_to flow_chapter_path(assigns(:flow_chapter))
  end

  test "should show flow_chapter" do
    get :show, id: @flow_chapter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flow_chapter
    assert_response :success
  end

  test "should update flow_chapter" do
    patch :update, id: @flow_chapter, flow_chapter: { chapter_id: @flow_chapter.chapter_id, flow_id: @flow_chapter.flow_id }
    assert_redirected_to flow_chapter_path(assigns(:flow_chapter))
  end

  test "should destroy flow_chapter" do
    assert_difference('FlowChapter.count', -1) do
      delete :destroy, id: @flow_chapter
    end

    assert_redirected_to flow_chapters_path
  end
end
