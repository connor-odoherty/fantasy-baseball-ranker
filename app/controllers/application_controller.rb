# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :require_login

  def hello; end

  private

  def require_login
    redirect_to sessions_new_path unless current_user
  end
end
