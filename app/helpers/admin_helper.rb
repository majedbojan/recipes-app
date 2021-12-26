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
    (0..(10.hours)).step(10.minutes).to_a.drop(1).map do |t|
      distance_of_time_in_words(t)
    end.uniq
  end

  def recipe_search_budget_options
    [
      ['All', ''],
      %w[Cheap cheap],
      %w[Average average_cost],
      %w[Expensive quite_expensive]

    ]
  end

  def recipe_search_difficulty_options
    [
      ['All', ''],
      ['Very easy', 'very_easy'],
      %w[easy easy],
      ['Average level', 'average_level'],
      %w[difficult Difficult]

    ]
  end
end
