class ApiController < ActionController::API
  def index
    render json: User.all
  end

  # @return [JSON]
  def profile
    begin
      @user = User.find(params[:id])
      render json: @user, except: [:id], status: :ok, root: true
    rescue ActiveRecord::RecordNotFound => exception
      render json: {'msg': exception.to_s}, code: :not_found
    end
  end

  # @return [String]
  # Generates a JWT token that is valid for 15 minutes
  # @todo The 'super_secret' must be replaced
  def generate_auth_token(data)
    return nil if data.nil?

    # The token will last only 15 minutes
    exp = Time.now + 60 * 15
    payload = {'data': data, 'exp': exp.to_i}
    JWT.encode payload, 'super_secret', 'HS256'
  end
end