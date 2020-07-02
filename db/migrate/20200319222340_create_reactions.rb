class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
		  t.references :owner, polymorphic: true
    	t.integer :user_id
    	t.integer :reactionType

      t.timestamps
    end
  end
end
