# frozen_string_literal: true

module AdminHelper
  def sidebar_nav_item(name, link, options = {})
    classes = %w[nav-link]
    classes << 'active' if request.path.starts_with?(link)
    icon    = options.fetch(:icon, nil)

    tag.li(class: 'nav-item') do
      link_to(link, class: classes) do
        safe_join([tag.span(nil, class: icon), name], ' ')
      end
    end
  end

  def recipe_time_options
    (0..(24.hours)).step(30.minutes).to_a.map do |t|
      l(Time.zone.at(t), format: :time_only)
    end
  end

  def recipe_search_budget_options
    [
      ['All', ''],
      %w[Cheap cheap],
      %w[Average average_cost],
      %w[Expensive quite_expensive]

    ]
  end
end
