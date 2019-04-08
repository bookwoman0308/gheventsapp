class EventFormsController < ApplicationController

  #Load a new instance of the form
  before_action :init_form!

  def index
    redirect_to action: :new
  end

  def create
    @form.submit!
  rescue ActiveModel::ValidationError => e
    Rails.logger.error(e)
    flash[:danger] ||= []
    @form.errors.full_messages.each{|msg| flash[:danger] << msg}
    redirect_with_params(action: :new)
  end

  private

  def init_form!
    #Instantiate new form object
    @form = EventForm.new()
  end

end

