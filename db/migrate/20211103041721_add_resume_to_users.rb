class AddResumeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :resume, :string
  end
end
