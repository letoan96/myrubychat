class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.datetime :added_at

      t.timestamps
    end
  end
end
