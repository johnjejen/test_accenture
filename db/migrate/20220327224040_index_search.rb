class IndexSearch < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Base.connection.execute <<-SQL
    ALTER TABLE users ADD FULLTEXT(first_name, last_name, email);
    SQL
  end
end
