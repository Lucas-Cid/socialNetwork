class ApiDashboardController < ApiController

  def react_to_post
    reaction = Reaction.new(
        :owner_type => params[:owner_type],
        :owner_id => params[:owner_id],
        :user_id => params[:user_id],
        :reactionType => (params[:reaction_type]).to_i
    )

    # Check if a reaction already exists
    previous_reaction = Reaction.where(owner_id: params[:owner_id]).where(user_id: params[:user_id]).first

    if previous_reaction.nil?
      # If there is no previous reaction, insert the new one
      reaction.save!
      render json: reaction, status: :ok
    elsif previous_reaction.reactionType == reaction.reactionType
      # If the previous reaction is the same as the new one, remove it
      previous_reaction.destroy!
      render json: {'msg': 'Reaction was removed'}, status: :ok
    else
      # destroy the previous reaction and add the new one
      # fixme should I updated it instead?
      previous_reaction.destroy!
      reaction.save!
      render json: {'msg': 'Reaction was updated.'}, status: :ok
    end
  end

  # return [JSON]
  # Return the necessary data (Posts, Reactions and Users) to render a Post card
  def show_posts
    user_data = verify_token params[:token]
    if not user_data.nil? and user_data.key?('data')
      @posts = Post.where('id < ?', params[:lastId].nil? ? Post.last.id + 1 : params[:lastId]).order(:id).last(20).reverse
      @reactions = Reaction.where(owner_id: @posts, user_id: user_data['data']['id'])

      # Get the [id] of all users related to the previous posts
      user_ids = []
      @posts.each do |p|
        user_ids.append(p.user_id)
      end

      @users = User.where(id: user_ids)
      render json: [@posts, @reactions, @users], status: :ok
    end
  end

# @return [JSON]
# @author Vinicius Quaresma da Luz
# Information can only be shared if user possesses a valid token
  def verify_token(token)
    if params[:token].nil? or params[:token].empty?
      render json: {'msg': 'Empty token.'}, status: :bad_request
      nil
    else
      begin
        # We get the [0] element because that is the one with the data
        # The [1] element contains the header, which is irrelevant for this action
        (JWT.decode params[:token], 'super_secret', true, {algorithm: 'HS256'})[0]

      rescue JWT::ExpiredSignature
        render json: {'msg': 'Expired token.'}, status: :unauthorized
        nil

      rescue JWT::VerificationError
        render json: {'msg': 'Could not verify token.'}, status: :unauthorized
        nil

      rescue JWT::DecodeError
        render json: {'msg': 'Malformed token.'}, status: :bad_request
        nil

      end
    end
  end
end