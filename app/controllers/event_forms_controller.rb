class EventFormsController < ApplicationController

  #Load a new instance of the form
  before_action :init_form!

  def index
    redirect_to action: :new
  end

  def create
    @form.submit!
    #Check user input and provide feedback if the user name does not follow GitHub rules.
    @form.validate_name!(params["event_form"]["user_name"])
    #Do some basic string cleaning to protect against malicious input.
    safe_name = @form.sanitize_name!(params["event_form"]["user_name"])
    #If there is not a successful API call, the rescue_from in the base class will render the call_error view.
    #Otherwise, print out the GitHub events for the specified user in the create view.
    render locals: {
      github_event: Githubcall.retrieve(safe_name),
      username: params["event_form"]["user_name"]
    }
  rescue ActiveModel::ValidationError => e
    Rails.logger.error(e)
    flash[:danger] ||= []
    @form.errors.full_messages.each{|msg| flash[:danger] << msg}
    redirect_with_params(action: :new)
  end

  def show
    if %w(invalid call_eror).include?(params[:id])
      render params[:id]
    else
      redirect_to action: :new
    end
  end

  private

  def init_form!
    #Instantiate new form object
    @form = EventForm.new()
  end

end

