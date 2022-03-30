class AddTokenStatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token_status, :string, :after => :tokens
  end
end
