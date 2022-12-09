class ApplicationController < ActionController::API
  include ActionController::Cookies
rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid
before_action :authorize


private
def handle_invalid(e)
  render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
end

def authorize
  user = User.find_by(id: session[:user_id])
  render json: {errors:["Not authorized"]}, status: :unauthorized unless user
end

end