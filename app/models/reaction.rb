class Reaction < ApplicationRecord
  validates :reactionType, presence: true

  enum reactionType: [:type1, :type2, :type3, :type4]
  enum postType: [:post, :comment]

  belongs_to :user
  belongs_to :owner, polymorphic: true

  before_destroy :undoReaction

  after_create do |s|
    addReaction
  end

  def postOrComment(owner_type)
    if owner_type == "Post"
      Post
    else
      Commentary
    end
  end

  def self.safe_add_reaction(object_type, object_owner_id, reaction_type)
    reacted_object_type = (object_type).to_i == 0 ? Post : Commentary
    reacted_object = reacted_object_type.find(object_owner_id)

    case reaction_type
    when 1
      reacted_object.update(reactionType1: reacted_object[:reactionType1] + 1)
    when 2
      reacted_object.update(reactionType2: reacted_object[:reactionType2] + 1)
    when 3
      reacted_object.update(reactionType3: reacted_object[:reactionType3] + 1)
    when 4
      reacted_object.update(reactionType4: reacted_object[:reactionType4] + 1)
    end

    {'msg': "Reaction #{reaction_type} was updated on object of id #{reacted_object.id}.", 'status': 200}
  end

  def addReaction
    type = postOrComment(owner_type)

    toBeReacted = type.find(owner_id)
    case reactionType
    when "type1"
      toBeReacted.update(reactionType1: toBeReacted[:reactionType1] + 1)
    when "type2"
      toBeReacted.update(reactionType2: toBeReacted[:reactionType2] + 1)
    when "type3"
      toBeReacted.update(reactionType3: toBeReacted[:reactionType3] + 1)
    when "type4"
      toBeReacted.update(reactionType4: toBeReacted[:reactionType4] + 1)
    end
  end

  def self.alreadyReacted(params)
    @user = User.find(params.require(:user_id))
    @userReaction = @user.reactions.where(owner_id: params.require(:owner_id), owner_type: params.require(:owner_type)).first
    if @userReaction.present?
      if @userReaction.reactionType == params.require(:reactionType)
        @userReaction.destroy
      else
        @userReaction.undoReaction
        @userReaction.update(reactionType: params.require(:reactionType))
        @userReaction.addReaction

      end
      return true
    end
    return false
  end

  def undoReaction
    type = postOrComment(owner_type)

    toLostReaction = type.find(owner_id)
    case reactionType
    when "type1"
      toLostReaction.update(reactionType1: toLostReaction[:reactionType1] - 1)
    when "type2"
      toLostReaction.update(reactionType2: toLostReaction[:reactionType2] - 1)
    when "type3"
      toLostReaction.update(reactionType3: toLostReaction[:reactionType3] - 1)
    when "type4"
      toLostReaction.update(reactionType4: toLostReaction[:reactionType4] - 1)
    end
  end

end
