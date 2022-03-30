class CreateStatusAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :status_accounts do |t|
      t.string :status
      t.timestamps
    end

    st = StatusAccount.new
    st.status = "Active"
    st.save

    st = StatusAccount.new
    st.status = "Desactive"
    st.save


  end
end
