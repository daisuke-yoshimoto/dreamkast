class Forbidden < ActionController::ActionControllerError; end

class ApplicationController < ActionController::Base
  before_action :set_raven_context

  def home_controller?
    controller_name == "home"
  end

  def admin_controller?
    controller_name == "admin"
  end

  def event_name
    params[:event]
  end

  helper_method :home_controller?, :admin_controller?, :event_name

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  rescue_from Forbidden, with: :render_403
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_403(e)
    @exception = e
    render template: 'errors/error_403', status: 403, layout: 'application', content_type: 'text/html'
  end

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
end
