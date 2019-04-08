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

  def test_valid_user_after_submit
    form_params = {
      event_form: {
        user_name: "bookwoman0308"
      }
    }
    post "/forms/github-search", params: form_params
    assert_response :ok
  end

  def test_nonexist_user_after_submit
    form_params = {
      event_form: {
        user_name: "jump1234"
      }
    }
    post "/forms/github-search", params: form_params
    assert_response :forbidden
  end

  def test_invalid_user_double_hyphens_after_submit
    form_params = {
      event_form: {
        user_name: "jump--1234"
      }
    }
    post "/forms/github-search", params: form_params
    assert_response :forbidden
  end

  def test_invalid_user_starts_with_hyphen_after_submit
    form_params = {
      event_form: {
        user_name: "-person"
      }
    }
    post "/forms/github-search", params: form_params
    assert_response :forbidden
  end

  def test_invalid_user_ends_with_hyphen_after_submit
    form_params = {
      event_form: {
        user_name: "person-"
      }
    }
    post "/forms/github-search", params: form_params
    assert_response :forbidden
  end

    def test_invalid_user_name_too_long_after_submit
    form_params = {
      event_form: {
        user_name: "123456789123456789123456789123456789123456789"
      }
    }
    post "/forms/github-search", params: form_params
    assert_response :forbidden
  end

end
