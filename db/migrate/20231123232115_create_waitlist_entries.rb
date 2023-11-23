class CreateWaitlistEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :waitlist_entries do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
