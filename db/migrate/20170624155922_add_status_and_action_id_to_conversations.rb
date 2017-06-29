class AddStatusAndActionIdToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :status, :integer
    add_column :conversations, :action_id, :integer
  end
end
