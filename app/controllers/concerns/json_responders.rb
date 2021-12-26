# frozen_string_literal: true

module JsonResponders
  # Render a message
  def render_success(message: I18n.t(:data_found), data: {})
    render json: { message: message, data: data }, status: :ok
  end

  # Render Created
  def render_created(data:, message: I18n.t(:created_successfully))
    render json: { message: message, data: data }, status: :ok
  end

  ## Error Responders
  def render_bad_request(error: 1000, **options)
    render_smart_error(error: error, **options)
  end

  def render_unauthorized(error: 1101, **options)
    render_smart_error(error: error, status: :unauthorized, **options)
  end

  def render_forbidden(error: 1102, **options)
    render_smart_error(error: error, status: :forbidden, **options)
  end

  def render_unprocessable_entity(error: 1103, **options)
    render_smart_error(error: error, status: :unprocessable_entity, **options)
  end

  def render_not_found(error: 1105, **options)
    render_smart_error(error: error, status: :not_found, **options)
  end

  def render_smart_error(error:, **options)
    render(json: {
             error_code: options[:error_code],
             message:    options[:message],
             status:     (options[:status] || :bad_request)
           })
  end
end
