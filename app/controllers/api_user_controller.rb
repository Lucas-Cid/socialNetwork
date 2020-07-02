class ApiUserController < ApiController

  # @return [JSON]
  # @author Vinicius Quaresma da Luz
  # @note Operation result is informed mainly by HTTP status codes
  def login
    @user = User.find_by_email(params[:email])

    # User is not yet registered
    if @user.nil?
      render json: {
          'msg': 'The email \'' + params[:email] + '\' was not found'
      }, status: :not_found

    # User is registered and password matches
    elsif @user.valid_password?(params[:password])
      render json: {
          'msg': 'Login approved',
          'token': generate_auth_token(@user.as_json),
          'data': @user.as_json
      }, status: :accepted

    # User informed a bad password
    else
      render json: {
          'c': -1,
          'msg': 'The password informed does not match our registers'
      }, status: :unauthorized
    end
  end

  # @return [JSON]
  # @author Vinicius Quaresma da Luz
  def register
    @user = User.new(
        :name => params[:name],
        :password => params[:password],
        :username => params[:username],
        :email => params[:email]
    )

    begin
      @user.save!
      render json: {'msg': 'User created successfully', 'data': @user.as_json}, status: :created
    rescue ActiveRecord::RecordInvalid
      render json: {'errors': @user.errors}, status: :bad_request
    end
  end
end