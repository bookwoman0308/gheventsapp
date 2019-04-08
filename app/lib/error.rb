# Namespace containing all error classes.
module Error
  # Base class for all errors.
  class BaseError < StandardError; end

  # Raised for unsuccessful API call to GitHub Events API.
  class CallError < BaseError; end

  # Raised for invalid GitHub user names.
  class NameInvalidError < BaseError; end
end
