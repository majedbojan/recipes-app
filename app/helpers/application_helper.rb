# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def alert_style(type)
    case type
    when 'alert'  then 'danger'
    when 'notice' then 'info'
    else type || 'info'
    end
  end

  # @param time [Time|Date] Time object that need to be formatted
  # @param format [Symbol] the time format as the i18n formats
  def format_timestamp(time, format = :short)
    return time if time.nil? || !(time.is_a?(Time) || time.is_a?(Date))

    I18n.l(time.in_time_zone('Riyadh'), format: format)
  end

  # TODO: remove only_path as production require full image path
  def image_path(img)
    Rails.application.routes.url_helpers.rails_blob_path(img, only_path: true)
  end

  def money(amount)
    return 'Free' if amount.nil? || amount.zero?

    number_to_currency(amount, precision: 2, unit: 'SAR ')
  end

  def disable_with_spinner(text = nil)
    safe_join(
      [
        tag.span(nil, class: 'spinner-border spinner-border-sm', role: 'status'),
        text
      ], ' '
    )
  end

  def book_button(label: 'Add Comment', disabled_label: 'Unavailable', disabled: false, **args)
    classes = %w[btn btn-primary btn-lg px-5] + Array(args.fetch(:class, nil))

    tag.button(disabled ? disabled_label : label, class: classes, disabled: disabled, data: { toggle: 'modal', target: '#Add Comment' })
  end

  def render_form_error(error)
    return if error.blank?
    return tag.div(error, class: 'alert alert-danger') unless error.is_a?(ActiveModel::Errors)

    tag.div(class: 'alert alert-danger') do
      tag.ul(class: 'm-0') do
        safe_join(error.full_messages.map { |m| tag.li(m) })
      end
    end
  end
end
