class CreatePostCommentaries < ActiveRecord::Migration[5.2]
  def change
    create_table :post_commentaries do |t|
    	t.integer	:post_id
    	t.integer	:commentary_id
      t.timestamps
    end
  end
end
