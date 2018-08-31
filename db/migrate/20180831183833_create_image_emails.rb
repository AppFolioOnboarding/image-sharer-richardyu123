class CreateImageEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :image_emails do |t|
      t.string :message
      t.string :image_link, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
