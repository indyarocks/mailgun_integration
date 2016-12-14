class CreateMailgunEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :mailgun_events do |t|
      t.belongs_to :message, index: true, null: false
      t.integer :event, null: false
      t.string :ip_address
      t.timestamps
    end
  end
end
