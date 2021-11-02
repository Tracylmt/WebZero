class CreateWebsites < ActiveRecord::Migration[6.1]
  def change
    create_table :websites do |t|
      t.string :website_address
      t.string :username

      t.timestamps
    end
  end
end
