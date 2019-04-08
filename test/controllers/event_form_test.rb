require 'test_helper'

class EventFormsControllerTest < ActionDispatch::IntegrationTest

  def test_root_path
    get "/"
    assert_redirected_to "/forms/github-search"
  end

  def test_app_path
    get "/forms/github-search"
    assert_redirected_to "/forms/github-search/new"
    follow_redirect!
    assert_response :ok
  end

  def test_new_page_renders_with_correct_headline
    get "/forms/github-search"
    follow_redirect!
    assert_select "h1", /GitHub Events API User Search/
  end

  def test_submit_button_text
    get new_event_form_path
    assert_select 'form input[type="submit"][value="Submit"]'
  end

end
