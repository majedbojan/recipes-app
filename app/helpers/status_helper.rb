# frozen_string_literal: true

module StatusHelper
  def status_label(status)
    tag.span(status.humanize, class: "text-#{status_colors(status)}")
  end

  def status_colors(text)
    case text.to_s
    when 'active', 'confirmed'  then 'success'
    when 'inactive', 'rejected' then 'danger'
    when 'canceled'          then 'muted'
    when 'pending'           then 'warning'
    end
  end

  def enum_label(label)
    tag.span(label.humanize, class: 'text-muted')
  end
end
