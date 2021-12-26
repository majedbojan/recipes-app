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
  def render_bad_request(error: 1000, message: '', **options)
    render_smart_error(error: error, message: message, **options)
  end

  def render_unauthorized(error: 1101, **options)
    render_smart_error(error: error, status: :unauthorized, **options)
  end

  def render_forbidden(error: 1102, **options)
    render_smart_error(error: error, status: :forbidden, **options)
  end

  def render_unprocessable_entity(message:, error: 1103)
    render_smart_error(error: error, message: message, status: :unprocessable_entity)
  end

  def render_not_found(error: 1105, **options)
    render_smart_error(error: error, status: :not_found, **options)
  end

  def render_smart_error(error:, message: '', status: :bad_request, **_options)
    render(json: {
             error:   error,
             message: message,
             status:  status
           })
  end
end
