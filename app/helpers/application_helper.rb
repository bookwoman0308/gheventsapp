module ApplicationHelper
  def errors_for(model)
    return unless model.errors.any?

    content_tag(:div, class: "alert alert-warning") do
      concat content_tag(:h5, 'Please correct these errors:')

      content_tag(:ul) do
        model.errors.full_messages.each do |msg|
          concat content_tag(:li, msg).html_safe
        end
      end
    end
  end
end
