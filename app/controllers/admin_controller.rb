class AdminController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :check_admin

  skip_before_action :verify_authenticity_token if defined?(verify_authenticity_token) 
  respond_to :json

  private

  def check_admin
    if current_user.nil?
      render json: { error: "User not found" }, status: :unauthorized
    elsif current_user.admin? || current_user.staff_admin?
      true
    else
      render json: { error: "Admin access required" }, status: :forbidden
    end
  end

  def current_user
    if doorkeeper_token
      Rails.logger.debug "Doorkeeper token present: #{doorkeeper_token}"
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    else
      Rails.logger.info "No doorkeeper token found"
      nil
    end
  end
end
