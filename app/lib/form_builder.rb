# frozen_string_literal: true

class FormBuilder < ActionView::Helpers::FormBuilder
  def field_error(attribute, **options)
    return if errors.empty? && !errors.key?(attribute)

    @template.tag.div(errors[attribute].to_sentence, class: options.fetch(:class, 'invalid-feedback'))
  end

  %w[
    color
    date
    datetime
    datetime
    email
    file
    month
    password
    range
    search
    telephone
    text
    time
    url
    week
    year
  ].each do |input_type|
    define_method :"#{input_type}_field" do |attribute, options = {}|
      options[:class] = "#{options[:class]} is-invalid" if errors.key?(attribute)

      super(attribute, options) + field_error(attribute)
    end
  end

  def text_area(attribute, options = {})
    options[:class] = "#{options[:class]} is-invalid" if errors.key?(attribute)

    super(attribute, options) + field_error(attribute)
  end

  def errors
    object&.errors || {}
  end
end
