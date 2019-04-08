class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from StandardError do |error|
    log_error(error)
    render "errors/standard_error", status: :internal_server_error
  end

  rescue_from Error::NameInvalidError do |error|
    Rails.logger.error(error)
    render :invalid, status: :forbidden
  end

  rescue_from Error::CallError do |error|
    Rails.logger.error(error)
    render :call_error, status: :forbidden
  end

  private

  # Log an exception
  def log_error(error)
    logger.error({
      error: "#{error.inspect}",
      cause: "#{error.cause.inspect}",
    })
  end

  # Perform a redirect but keep all existing request parameters
  # This is a workaround for not being able to redirect a POST/PUT request.
  def redirect_with_params(opts={})
    redirect_to request.parameters.update(opts)
  end
end
