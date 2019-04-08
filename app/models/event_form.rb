class EventForm < Form

  # @!attribute [string] user_name
  attr_accessor :user_name

  #Raise error if the user input for the GitHub username does not follow the user community rules.
  def validate_name!(name)
    raise Error::NameInvalidError if is_name_invalid?(name)
  end

  #Check to see if the user name is valid according to the GitHub join rules
  def is_name_invalid?(name)
    name.length > 39 or name.include? "--" or name[0] == "-" or name[name.length-1] == '-'
  end

  #Remove weird characters that would not belong in a name
  def sanitize_name!(name)
    name.gsub(/[^0-9A-z.\-]/, '')
  end

  private

  def submit
    #Nothing needed here
  end

end
