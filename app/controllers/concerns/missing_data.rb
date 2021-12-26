# frozen_string_literal: true

module MissingData
  # Render and error if parameters are missing
  def missing_params!(*fields)
    missing_data(params, *fields)
  end

  def missing_headers!(*fields)
    missing_data(request.headers, *fields)
  end

  def missing_data(data, *required_fields)
    missing = []

    required_fields.each do |field|
      required_field = boolean?(data[field]) ? data[field].to_s : data[field]

      missing << field if required_field.blank?
    end
    raise(CustomException::BadRequestError, "Missing Parameters: #{missing.join(' ,')}") if missing.present?
  end

  def boolean?(value)
    [true, false].include?(value)
  end
end
