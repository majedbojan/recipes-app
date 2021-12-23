# frozen_string_literal: true

module Activatable
  extend ActiveSupport::Concern

  included do
    enum status: {
      inactive: 0,
      active:   1
    }
  end
end
