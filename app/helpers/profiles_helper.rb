# frozen_string_literal: true

module ProfilesHelper
  def profile_nav_item(name, link)
    link_to(
      name,
      link,
      class: "list-group-item list-group-item-action#{' active' if request.path == link}"
    )
  end
end
