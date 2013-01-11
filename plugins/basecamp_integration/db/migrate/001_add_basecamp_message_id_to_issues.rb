class AddBasecampMessageIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :basecamp_message_id, :integer
  end
end
