class AddReferencesStatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :status_account, foreign_key: true, :after => :token_close
  end
end
