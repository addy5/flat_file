class CreatePostsUsersJoin < ActiveRecord::Migration
  def change
    create_table :posts_users, :id => false do |t|
      t.column 'post_id', :integer
      t.column 'user_id', :integer
    end
  end
end
